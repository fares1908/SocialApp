import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/moduls/SocialApp/NewPostScreen.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context, state) {
        if(state is SocialNewPostState){
         navigateTo(context,NewPostScreen ()) ;
        };
      },
      builder:  (context, state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              Icon(

                  IconBroken.Notification,
                color: Colors.black,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                IconBroken.Search,
                color: Colors.black,

              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                label:'Home',
                icon: Icon(
                  IconBroken.Home,
                ),
              ),
              BottomNavigationBarItem(
                label:'Chats',
                icon: Icon(
                  IconBroken.Chat,
                ),
              ),
              BottomNavigationBarItem(
                label:'Post',
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
              ),
              BottomNavigationBarItem(
                label:'Users',
                icon: Icon(
                  IconBroken.Location,
                ),
              ),
              BottomNavigationBarItem(
                label:'Settings',
                icon: Icon(
                  IconBroken.Setting,
                ),
              ),
            ],
            onTap: (index) {
             cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
