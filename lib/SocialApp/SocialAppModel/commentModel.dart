class CommentModel{
  late String ?name;
  late String? uid;
  late String ?image;
  late String ?dateTime;
  late String ?text;
  late String ?commentImage;
  //make a comment
  CommentModel({
    this.name,
    this.dateTime,
    this.text,
    this.uid,
    this.image,
    this.commentImage,
    //make a comment
  });

  CommentModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    dateTime=json['dateTime'];
    text=json['text'];
    uid=json['uid'];
    image=json['image'];
    commentImage=json['commentImage'];
    //make a comment

  }

  Map<String,dynamic>toMap() {
    return{
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'uid':uid,
      'image':image,
      'commentImage':commentImage,
    };

  }
}