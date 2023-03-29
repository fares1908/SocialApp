import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/models/SocialAppModel/postModel.dart';
import 'package:abdullaa/moduls/SocialApp/NewComment.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/style/colors/colors.dart';
import 'package:abdullaa/style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder:(context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://img.freepik.com/free-photo/positive-mad-hatter-keeps-hand-hat-smiles-happily-takes-part-carnival-dresses-halloween-party-poses-against-rosy-wall_273609-44406.jpg?t=st=1677076293~exp=1677076893~hmac=2d05bede99148bfd96ed5e277e3e0b5057ea3f8386a926ab5d1be72aad6ceba0',
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
              ],
            ),
          ) ,
          fallback:(context) => Center(child: CircularProgressIndicator()) ,
          condition:  SocialCubit.get(context).posts.length>0&&SocialCubit.get(context).usermodel!=null,

        );
      },
     );
  }

  Widget buildPostItem(PostModel model,context , index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 15,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${model.image}'),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 15,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                  '${model.text}',
                  style: Theme.of(context).textTheme.subtitle1),
              // Row(
              //   children: [
              //     MaterialButton(
              //       padding: EdgeInsets.zero,
              //       height: 25,
              //       minWidth: 1,
              //       onPressed: () {},
              //       child: Text(
              //         '#software',
              //         style: TextStyle(
              //           color: defaultColor,
              //         ),
              //       ),
              //     ),
              //     MaterialButton(
              //       padding: EdgeInsets.zero,
              //       height: 25,
              //       minWidth: 1,
              //       onPressed: () {},
              //       child: Text(
              //         '#software',
              //         style: TextStyle(
              //           color: defaultColor,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              if(model.postImage !='')
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 14,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${ SocialCubit.get(context).likes[index]} ',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 14,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).usermodel?.image}'),
                    radius: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).getComments(
                        SocialCubit.get(context).postsId[index]);
                        navigateTo(context, NewComment());
                      },
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.caption?.copyWith(),
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 14,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
