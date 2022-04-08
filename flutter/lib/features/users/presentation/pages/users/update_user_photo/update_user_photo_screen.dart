import 'package:flutter/material.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';

import 'components/body.dart';

class UpdateUserPhotoScreen extends StatelessWidget{
  final User user;

  const UpdateUserPhotoScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    debugPrint('UpdateUserPhotoScreen  = $user');
    return Scaffold(
      appBar: AppBar(
          title: Text('تحديث الصورة الشخصية', style:  TextStyle(fontSize: 15))
      ),
      body: Body(user: user,),
    );
  }
}