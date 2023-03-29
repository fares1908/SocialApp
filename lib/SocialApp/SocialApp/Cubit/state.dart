abstract class SocialState{}
class SocialInitialState extends SocialState{}
class SocialGetUserSuccessState extends SocialState{}
class SocialGetUserLoadingState extends SocialState{}
class SocialGetUserErrorState extends SocialState{
  final String error;

  SocialGetUserErrorState(this.error);
}
class SocialGetAllUserSuccessState extends SocialState{}
class SocialGetAllUserLoadingState extends SocialState{}
class SocialGetAllUserErrorState extends SocialState{
  final String error;

  SocialGetAllUserErrorState(this.error);
}
class SocialGetPostSuccessState extends SocialState{}
class SocialGetPostLoadingState extends SocialState{}
class SocialGetPostErrorState extends SocialState{
  final String error;

  SocialGetPostErrorState(this.error);
}
class SocialLikePostSuccessState extends SocialState{}
class SocialLikePostErrorState extends SocialState{
  final String error;

  SocialLikePostErrorState(this.error);
}
class SocialChangBottomNavState extends SocialState{}
class SocialNewPostState extends SocialState{}
class SocialProfileImagePickedSuccessState extends SocialState{}
class SocialProfileImagePickedErrorState extends SocialState{}
class SocialCoverImagePickedSuccessState extends SocialState{}
class SocialCoverImagePickedErrorState extends SocialState{}
class SocialUploadProfileImageSuccessState extends SocialState{}
class SocialUploadProfileImageErrorState extends SocialState{}
class SocialUploadCoverImageSuccessState extends SocialState{}
class SocialUploadCoverImageErrorState extends SocialState{}
class SocialUserUpdateErrorState extends SocialState{
  final String error;

  SocialUserUpdateErrorState(this.error);
}
class SocialUpdateUserLoadingState extends SocialState{}
class SocialUpdateUserSuccessState extends SocialState{}
//post
class SocialCreatePostLoadingState extends SocialState{}
class SocialCreatePostSuccessState extends SocialState{}
class SocialCreatePostErrorState extends SocialState{}
class SocialPostImagePickedSuccessState extends SocialState{}
class SocialPostImagePickedErrorState extends SocialState{}
class SocialRemovePostImageState extends SocialState{}
//////////////////////////comment
class SocialCreateCommentLoadingState extends SocialState{}
class SocialCreateCommentSuccessState extends SocialState{}
class SocialCreateCommentErrorState extends SocialState{}
class SocialCommentImagePickedSuccessState extends SocialState{}
class SocialCommentImagePickedErrorState extends SocialState{}
class SocialRemovePostCommentState extends SocialState{}
class SocialGetCommentSuccessState extends SocialState{}
class SocialGetCommentLoadingState extends SocialState{}
class SocialGetCommentErrorState extends SocialState{
  final String error;

  SocialGetCommentErrorState(this.error);
}
class SocialLikeCommentSuccessState extends SocialState{}
class SocialLikeCommentErrorState extends SocialState{
  final String error;

  SocialLikeCommentErrorState(this.error);
}
//massage
class SocialSendMassageSuccessState extends SocialState{}
class SocialSendMassageErrorState extends SocialState{
  final String error;

  SocialSendMassageErrorState(this.error);
}
class SocialGetMassageSuccessState extends SocialState{}
class SocialGetMassageErrorState extends SocialState{
  final String error;

  SocialGetMassageErrorState(this.error);
}