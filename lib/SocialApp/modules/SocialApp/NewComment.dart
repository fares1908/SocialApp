import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/SocialAppModel/commentModel.dart';
import 'package:abdullaa/moduls/SocialApp/feeds/feed_screen.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewComment extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'COMMENTS',
              ),
            ),
          ),
          body: Column(

            children: [
              if(state is SocialCreateCommentLoadingState)
                LinearProgressIndicator(),
              if(state is SocialCreateCommentLoadingState)
                SizedBox(
                  height: 13,
                ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildComment(SocialCubit.get(context).comments[index],context,index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: SocialCubit.get(context).comments.length,
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Write a Comment'),
                ),
                trailing: InkWell(
                  onTap: () {
                if(SocialCubit.get(context).postImage==null) {
                  LinearProgressIndicator();
                  SocialCubit.get(context).createComment(
                    dateTime: DateTime.now().toString(),
                    Text: textController.text,
                  );
                }
                  },
                  child: Icon(
                    IconBroken.Send,
                  ),
                ),
              ),
            ],
          ),
        );
      },

    );
  }

  Widget buildComment(CommentModel model,context , index) => Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  '${SocialCubit.get(context).usermodel?.image}'),
              radius: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(
                    height: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                 '${model.text}',
                  style: TextStyle(
                    height: 1,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${DateTime.now().toString()}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(
                  IconBroken.Heart,
                  size: 14,
                  color: Colors.red,
                ),
                onTap: () {

                  SocialCubit.get(context).likeComment(SocialCubit
                      .get(context)
                      .commentsId[index]);

                },
              ),
            ),
          ],
        ),
      );
}
