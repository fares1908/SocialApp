abstract class SocialLoginState {}
class SocialLoginInitialState extends SocialLoginState {}
class SocialLoginLoadingState extends SocialLoginState {}
class SocialLoginSuccessState extends SocialLoginState {
  late String uid;

  SocialLoginSuccessState(this.uid);
}
class SocialLoginErrorState extends SocialLoginState {
  late final String error;
  SocialLoginErrorState(this.error);
}