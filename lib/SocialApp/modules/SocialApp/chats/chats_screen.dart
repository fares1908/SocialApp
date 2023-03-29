import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/SocialAppModel/SocialUserModel.dart';
import 'package:abdullaa/models/user/user_moduls.dart';
import 'package:abdullaa/style/colors/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/compounant/compounts.dart';
import 'chat_detials_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context, state) {

      },
      builder:(context, state) =>  ConditionalBuilder(
        builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildChatUser(SocialCubit.get(context).users[index],context),
          separatorBuilder:(context, index) =>myDivider(),
          itemCount: SocialCubit.get(context).users.length,
    ),

        fallback:(context) => Center(child: CircularProgressIndicator()),
        condition:SocialCubit.get(context).users.length>0 ,
      ),
    );
  }

  Widget buildChatUser(SocialUserModel model,context) => InkWell(
    onTap: () {
      navigateTo(context,
        ChatDetails(
        userModel:model,
      ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    '${model.image}'),
                radius: 25,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                  '${model.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                fontSize: 13,
                ),
              ),
            ],
          ),
    ),
  );
}
