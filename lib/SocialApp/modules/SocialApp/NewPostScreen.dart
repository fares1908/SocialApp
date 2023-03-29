import 'dart:io';

import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/user/user_moduls.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../style/icon_broken.dart';

class NewPostScreen extends StatelessWidget {

  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener:(context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            leading: Icon(
              IconBroken.Arrow___Left_2,
            ),
            title: Text(
              'Add Post',
            ),
            actions: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              child: InkWell(
              child: Text(
              'POST',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
                onTap: (){
                var now=DateTime.now();
                if(SocialCubit.get(context).postImage==null){
                  SocialCubit.get(context).createPost(
                      dateTime:now.toString(),
                      Text:textController.text,
                  );


                } else
                {
                  SocialCubit.get(context).uploadPostImage(

                      dateTime: now.toString(),
                      text:   textController.text,
                  );
                }
                },
              ),
            ),
          ),
            ],

          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 13,
                  ),
                Row(

                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/positive-mad-hatter-keeps-hand-hat-smiles-happily-takes-part-carnival-dresses-halloween-party-poses-against-rosy-wall_273609-44406.jpg?t=st=1677076293~exp=1677076893~hmac=2d05bede99148bfd96ed5e277e3e0b5057ea3f8386a926ab5d1be72aad6ceba0'),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Fares Samy',
                      style: TextStyle(
                        height: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration:InputDecoration(
                      hintText: 'what is on your mind...',
                      border: InputBorder.none,

                    ),


                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image:
                          FileImage(SocialCubit.get(context).postImage
                              as  File,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          (SocialCubit.get(context).removePostImage())   ;
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                           SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add Photo')
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text('#tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        );
      },

    );
  }
}
