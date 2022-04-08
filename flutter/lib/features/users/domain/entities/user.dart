import 'package:flutter/material.dart';

class  User {
  int id = 1;
  String name;
  String photo;
  String createdAt;
  String updatedAt;

  User({
    this.id,
    this.name,
    this.photo,
    this.createdAt,
    this.updatedAt,
   });

  User.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    name = json['name'],
    photo = json['photo'],
    createdAt = json['created_at'],
    updatedAt = json['updated_at']
  ;

  @override
  String toString() {
    return 'User{id: $id, name: $name, photo: $photo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
