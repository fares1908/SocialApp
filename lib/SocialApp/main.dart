
import 'package:abdullaa/lay_out/news_app/cubit/states.dart';
import 'package:abdullaa/lay_out/shop_layout/ShopLayout.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/cubit.dart';
import 'package:abdullaa/lay_out/shop_layout/cubit/states.dart';
import 'package:abdullaa/lay_out/todo_app/cubit.dart';
import 'package:abdullaa/lay_out/todo_app/state.dart';
import 'package:abdullaa/moduls/SocialApp/login/social_login.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/shared/compounant/constant.dart';
import 'package:abdullaa/shared/network/dio_helper.dart';
import 'package:abdullaa/shared/network/network.local.dart';
import 'package:abdullaa/style/themes/themes.dart';
import 'package:abdullaa/task3.dart';
import 'package:abdullaa/task_2.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lay_out/SocialApp/Cubit/cubit.dart';
import 'lay_out/SocialApp/SocialLayout.dart';
import 'lay_out/news_app/cubit/cubit.dart';
import 'moduls/shopApp/login/Shop_Lgin_Screen.dart';
import 'moduls/shopApp/ShopHomeScreens/onBordingScreen.dart';
import 'shared/bloc_observer.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(text: 'onBackGroundMessage', state: ToastStates.SUCCESS);
}
void main() async{

 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

  var firebaseToken=await FirebaseMessaging.instance.getToken();
 print('FARES');
  print( firebaseToken );
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text: "on message", state:ToastStates.SUCCESS);
  });

 FirebaseMessaging.onMessageOpenedApp.listen((event) {
   print('on message opened app  ');
   print(event.data.toString());
   showToast(text: "on message opened app", state:ToastStates.SUCCESS);

 });
 FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
 Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  await CashHelper.init();
  Widget ? widget;
  // bool ? onBoarding=CashHelper.getData(key: 'onBoarding');
 // token = CashHelper.getData(key: 'token');
 // print(token);
 //  if(onBoarding!=null){
 //    if(token!=null){
 //      widget=ShopLayout();}
 //    else
 //      widget=Shop_Login();
 //  }else{
 //    widget=onBoardingScreen();
 //  }
 uid = CashHelper.getData(key: 'uid');
 uid=FirebaseAuth.instance.currentUser?.uid;
 // print(uid);
 if(uid !=null){
   widget=SocialLayout();
 }else{
   widget=Social_Login_Screen();
 }
  runApp( MyApp(
   startWidget:widget,
  ));
}
bool onBoarding=CashHelper.getData(key: 'onBoarding');

class  MyApp extends StatelessWidget {

 final Widget startWidget;

  MyApp({
 required this.startWidget,
});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
        create: (context) => newsappcubit()
      ..getBusiness()
      ..getSports()
      ..getScience()
      ..getHealth()
        ),
        BlocProvider(
            create:(BuildContext context)=>ShopCubit()
              ..getHomeData()..getCategoryData()..getFavoriteData()..getProfileData(),
        ),
        BlocProvider(
            create:(BuildContext context)=>AppCubit(),
        ),
        BlocProvider(
          create:(BuildContext context)=>SocialCubit()
            ..getUserData()..getPosts()..getComments(),
        ),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context ,state){
          return  MaterialApp(

            theme: lightTheme,
            darkTheme: darkTheme,
            // themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home:  startWidget,
          );
        },

      ),
    );
  }
}
