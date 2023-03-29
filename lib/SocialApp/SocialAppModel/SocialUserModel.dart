class SocialUserModel {
  late String? name;
  late String? email;
  late String? phone;
  late String? uid;
  late String? image;
  late String? bio;
  late String? cover;
 late bool ?isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.bio,
    this.image,
    this.cover,
    this.isEmailVerified,
  });
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    bio = json['bio'];
    phone = json['phone'];
    image = json['image'];
    uid = json['uid'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'bio':bio,
      'cover':cover,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
