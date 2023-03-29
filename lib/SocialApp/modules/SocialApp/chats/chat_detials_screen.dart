import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/SocialAppModel/SocialUserModel.dart';
import 'package:abdullaa/models/SocialAppModel/massageModel.dart';
import 'package:abdullaa/style/colors/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../style/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetails({
    required this.userModel,
  });
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uid!);
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {
            if(state is SocialSendMassageSuccessState){
              textController.text='';
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '${userModel.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
                condition: SocialCubit
                    .get(context)
                    .messageModelList
                    .length > 0,
                builder: (context) =>
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message =
                                SocialCubit
                                    .get(context)
                                    .messageModelList[index];
                                if (SocialCubit
                                    .get(context)
                                    .usermodel!
                                    .uid ==
                                    message.senderID)
                                  return buildMyMassage(message);

                                return buildSenderMassage(message);
                              },
                              itemCount:
                              SocialCubit
                                  .get(context)
                                  .messageModelList
                                  .length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    height: 12,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: textController,
                                decoration:
                                InputDecoration(labelText: 'Write a Massage'),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uid,
                                    dataTime: DateTime.now().toString(),
                                    text: textController.text,
                                  );
                                },
                                child: Icon(
                                  IconBroken.Send,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

              ),
            );
          },
        );
      }
      );
  }

  }


  Widget buildSenderMassage(MessagesModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text('${model.text}'),
        ),
      );
  Widget buildMyMassage(MessagesModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text('${model.text}'),
        ),
      );

