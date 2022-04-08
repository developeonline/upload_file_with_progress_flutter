class PersonalPic {
  String photoLink;
  int isActive;

  PersonalPic({
          this.photoLink,
          this.isActive,
  });

  PersonalPic.fromJson(Map<String, dynamic> json) :
    photoLink = json['photo_link'],
    isActive = json['is_active'] ;

  @override
  String toString() {
    return 'PersonalPic{photoLink: $photoLink, isActive: $isActive}';
  }
}
