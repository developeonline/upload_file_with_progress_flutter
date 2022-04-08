import 'package:flutter/material.dart';
import 'package:upload_percentage/core/util/constants.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';

class HomeScreen extends StatelessWidget{
  User user= User(
      id: 1,
      name: "Mohamed",
      photo: "",
      createdAt: "5-4-2022",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: TextButton.icon(
          icon: Icon(Icons.account_box_outlined),
          label: Text('تحديث الصورة الشخصية', style: TextStyle(fontSize: 20),),
          onPressed: (){
            Navigator.of(context).pushNamed(Constants.UpdateUserPhotoRoute, arguments: user);
          },
        ),
      ),
    );
  }
}