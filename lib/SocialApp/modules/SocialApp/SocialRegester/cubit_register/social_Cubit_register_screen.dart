import 'package:abdullaa/models/SocialAppModel/SocialUserModel.dart';
import 'package:abdullaa/models/SocialAppModel/SocialUserModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/SocialAppModel/SocialUserModel.dart';
import '../../../../models/SocialAppModel/SocialUserModel.dart';
import '../../../../models/SocialAppModel/SocialUserModel.dart';
import 'social_state_register_screen.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState>{

  SocialRegisterCubit():super(SocialRegisterInitialState());
static SocialRegisterCubit get(context)=>BlocProvider.of(context);
    void userRegister({
      required String name,
      required String email,
      required String password,
      required String phone,

    }){
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value) {
        userCreate(
            name: name,
            email: email,
            phone: phone,
            uid: value.user!.uid,
        );
        emit(SocialRegisterSuccessState());
      }).catchError((error){
        emit(SocialRegisterErrorState(error.toString()));
      });
    }

    void userCreate({
      required String name,
      required String email,
      required String phone,
      required String uid,

}){
   SocialUserModel model=SocialUserModel(
     email: email,
     name: name,
     phone: phone,
     uid: uid,
     cover: 'https://img.freepik.com/free-photo/white-notebook-black-data-firewall_1150-1733.jpg?w=996&t=st=1677647122~exp=1677647722~hmac=ecac368554a230cb81e073e5783b903df4f0dcb4cc0957e25b49a1b0e5cf1bf7',
     bio: 'Hello World',
     image: 'https://img.freepik.com/free-photo/young-handsome-african-american-boy-singing-emotional-with-micro_1258-120975.jpg?w=1380&t=st=1677597250~exp=1677597850~hmac=8d4fbe96e81c7ddf3b88f11420268c8fecf7b508b6b8f655b540abf479816001',
     isEmailVerified: false,
   );
     FirebaseFirestore.instance.collection('user')
         .doc(uid)
         .set(model.toMap())
         .then((value) {
           emit(SocialCreateUserSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(SocialCreateUserErrorState(error.toString()));
     });
    }
}