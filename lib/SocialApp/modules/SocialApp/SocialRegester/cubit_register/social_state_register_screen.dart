

abstract class SocialRegisterState {}
class SocialRegisterInitialState extends SocialRegisterState {}
class SocialRegisterLoadingState extends SocialRegisterState {}
class SocialRegisterSuccessState extends SocialRegisterState {}
class SocialRegisterErrorState extends SocialRegisterState {
  late final String error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends SocialRegisterState {}
class SocialCreateUserErrorState extends SocialRegisterState {
  late final String error;
  SocialCreateUserErrorState(this.error);
}