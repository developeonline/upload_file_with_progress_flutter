import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';
import 'package:upload_percentage/features/users/presentation/providers/users/users_provider.dart';
import 'customer_personal_pic.dart';

class Body extends StatelessWidget {
  final User user;
  const Body({@required this.user});

  @override
  Widget build(BuildContext context) {
    debugPrint('Body  = $user');
    return SingleChildScrollView(

      padding: EdgeInsets.symmetric(vertical: 20),
      child: buildBody(context: context, user: user)

    );
  }

  Widget buildBody({BuildContext context, User user, }){
    UsersProvider myUserProvider = Provider.of<UsersProvider>(context, listen: false);

    return Column(
      children: [
        Center(child: CustomerPersonalPic(user: user,)),
        SizedBox(height: 20),
         ],
    );
  }

}
