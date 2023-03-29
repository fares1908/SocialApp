import 'dart:io';

import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/user/user_moduls.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();

  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).usermodel;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Edit Profile',
            ),
            actions: [
              Center(
                child: InkWell(
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView (
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel?.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 65,
                              child: CircleAvatar(
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel?.image}')
                                    : FileImage(profileImage) as ImageProvider,
                                radius: 60,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defultbutton(
                                  text: 'Upload Profile',
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage
                                      (
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                    );

                                  },
                                ),
                                if(state is SocialUpdateUserLoadingState)
                                LinearProgressIndicator(),
                                if(state is SocialUpdateUserLoadingState)
                                SizedBox(
                                  height: 5,
                                ),

                              ],
                            ),
                          ),
                        SizedBox(
                          width: 15,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defultbutton(
                                  text: 'Upload Cover',
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage
                                      (
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                ),
                                if(state is SocialUpdateUserLoadingState)
                                LinearProgressIndicator(),
                                if(state is SocialUpdateUserLoadingState)
                                SizedBox(
                                  height: 5,
                                ),

                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 17,
                    ),
                  deflutformfield(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    icon: IconBroken.User,
                    validate: (value) {
                      if (value == null && value.toString().isEmpty) {
                        print('Please enter name');
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  deflutformfield(
                    controller: bioController,
                    type: TextInputType.name,
                    label: 'Bio',
                    icon: IconBroken.Info_Circle,
                    validate: (value) {
                      if (value == null && value.toString().isEmpty) {
                        print('Please enter Bio');
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  deflutformfield(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    icon: IconBroken.Call,
                    validate: (value) {
                      if (value == null && value.toString().isEmpty) {
                        print('Please enter Phone');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
