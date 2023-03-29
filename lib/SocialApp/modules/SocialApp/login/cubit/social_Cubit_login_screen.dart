
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'social_state_login_screen.dart';

class SocialLoginCubit extends Cubit<SocialLoginState>{

  SocialLoginCubit():super(SocialLoginInitialState());
static SocialLoginCubit get(context)=>BlocProvider.of(context);

    void userLogin({
      required String email,
      required String password,
    }){
      emit(SocialLoginLoadingState());
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value) {
        print(value.user?.email);
        print(value.user?.uid);
        emit(SocialLoginSuccessState(value.user!.uid));

      }).catchError((error){
        emit(SocialLoginErrorState(error.toString()));
      });
    }
}
