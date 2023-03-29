import 'dart:io';

import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/SocialAppModel/commentModel.dart';
import 'package:abdullaa/models/SocialAppModel/massageModel.dart';
import 'package:abdullaa/models/SocialAppModel/postModel.dart';
import 'package:abdullaa/moduls/SocialApp/NewPostScreen.dart';
import 'package:abdullaa/models/SocialAppModel/SocialUserModel.dart';
import 'package:abdullaa/models/user/user_moduls.dart';
import 'package:abdullaa/moduls/SocialApp/chats/chats_screen.dart';
import 'package:abdullaa/moduls/SocialApp/notifications/notifaction_screen.dart';
import 'package:abdullaa/moduls/SocialApp/settings/setting_screen.dart';
import 'package:abdullaa/moduls/SocialApp/users/user_screen.dart';
import 'package:abdullaa/moduls/search/search_screen.dart';
import 'package:abdullaa/moduls/user/user_screen.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../moduls/SocialApp/feeds/feed_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? usermodel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      print(uid);
      usermodel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangBottomNavState());
    }
  }

  List<String> titles = [
    'Home Feeds',
    'Chats',
    'Post',
    'User Feeds',
    'Setting Feeds',
  ];
  File? profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      profileImage = File(pickedFile!.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      coverImage = File(pickedFile!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No Image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  Future<void> updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) async {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? usermodel!.image,
      uid: usermodel!.uid,
      email: usermodel!.email,
      cover: cover ?? usermodel!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(usermodel?.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(SocialUpdateUserSuccessState());
    }).catchError((error) {
      emit(SocialUserUpdateErrorState(error.toString()));
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      postImage = File(pickedFile!.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(
          dateTime: dateTime,
          Text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  Future<void> createPost({
    required String dateTime,
    required String Text,
    String? postImage,
  }) async {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: usermodel?.name,
      image: usermodel?.image,
      uid: usermodel?.uid,
      dateTime: dateTime,
      text: Text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  Future<void> getPosts() async {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }
  /////////////////////////

  Future<void> createComment({
    //required String postId,
    required String dateTime,
    required String Text,
    String? commentImage,
  }) async {
    emit(SocialCreateCommentLoadingState());
    CommentModel model = CommentModel(
      name: usermodel?.name,
      image: usermodel?.image,
      uid: usermodel?.uid,
      dateTime: dateTime,
      text: Text,
      commentImage: commentImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessState());
    }).catchError((error) {
      emit(SocialCreateCommentErrorState());
    });
  }

  List<CommentModel> comments = [];
  List<String> commentsId = [];
  List<int> commentLike = [];
  //  Future<void> getPosts() async {
  //     FirebaseFirestore.instance.collection('posts').get().then((value) {
  //         value.docs.forEach((element) {
  //         element.reference.collection('likes').get().then((value) {
  //           likes.add(value.docs.length);
  //           postsId.add(element.id);
  //           posts.add(PostModel.fromJson(element.data()));
  //         }).catchError((error) {});
  //       });
  //       emit(SocialGetPostSuccessState());
  //     }).catchError((error) {
  //       emit(SocialGetPostErrorState(error.toString()));
  //     });
  //   }

  Future<void> getComments([String? postsId]) async {
    emit(SocialGetCommentLoadingState());
    FirebaseFirestore.instance.collection('comments').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likeComments').get().then((value) {
          commentLike.add(value.docs.length);
          commentsId.add(element.id);
          comments.add(CommentModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetCommentSuccessState());
    }).catchError((error) {
      emit(SocialGetCommentErrorState(error.toString()));
    });
  }

  void likeComment(String commentId) {
    FirebaseFirestore.instance
        .collection('comments')
        .doc(commentId)
        .collection('likes')
        .doc(usermodel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikeCommentSuccessState());
    }).catchError((error) {
      emit(SocialLikeCommentErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  Future<void> getUsers() async {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != usermodel?.uid)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        emit(SocialGetUserErrorState(error.toString()));
      });
  }

  Future<void> sendMessage({
    required String ? receiverId,
    required String ?dataTime,
    required String ?text,
  }) async {
    MessagesModel model =MessagesModel(
      text: text,
      dateTime:dataTime ,
      receiverId:receiverId ,
      senderID: usermodel!.uid,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(usermodel!.uid)
        .collection('chats')
        .doc(receiverId )
        .collection('messages')
        .add(model.toMap())
    .then((value) {
      emit(SocialSendMassageSuccessState());

    }).catchError((error){
      emit(SocialSendMassageErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(usermodel?.uid )
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMassageSuccessState());

    }).catchError((error){
      emit(SocialSendMassageErrorState(error.toString()));
    });
  }
  List<  MessagesModel>messageModelList=[];
  void getMessages({
    required String receiverId,
  }){
    // emit(SocialGetChatUsersLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(usermodel?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messageModelList.clear();
      event.docs.forEach((element) {
        messageModelList.add( MessagesModel.fromJson(element.data()));
      });
      emit(SocialGetMassageSuccessState());
    });

  }
}
