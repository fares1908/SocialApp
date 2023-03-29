import 'package:abdullaa/lay_out/SocialApp/Cubit/cubit.dart';
import 'package:abdullaa/lay_out/SocialApp/Cubit/state.dart';
import 'package:abdullaa/moduls/SocialApp/edit_profile/editProfile.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var userModel=SocialCubit.get(context).usermodel;
    return  BlocConsumer<SocialCubit,SocialState> (
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${userModel?.cover}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(

                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      radius: 65,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${userModel?.image}'),
                        radius: 60,

                      ),
                    ),
                  ],
                ),
              ),

              Text(
                'Fares Samy',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel?.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style:Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              '   Posts',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '256',
                              style:Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              '   Photos',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100k',
                              style:Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Followers',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '1165',
                              style:Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Following',
                              style:Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed:(){},
                        child: Text(
                          'Edit Profile'
                        ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                    onPressed:(){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      Icons.edit,
                    ),
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
