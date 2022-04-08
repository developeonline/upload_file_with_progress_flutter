import 'package:flutter/material.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';
import 'package:upload_percentage/features/users/presentation/pages/home/home_screen.dart';
import 'package:upload_percentage/features/users/presentation/pages/users/update_user_photo/update_user_photo_screen.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
   // debugPrint('settings.name is {$settings.name}');
    switch(settings.name){ // name of the route
      case '/': // '/' home page
      case '/home': // '/home' home page
        return MaterialPageRoute(builder: (_)=> HomeScreen()); // HomeScreen()
      case '/update_user_photo':
        return args is User
          ? MaterialPageRoute(builder: (_)=> UpdateUserPhotoScreen(user: args ,))
              : _errorRoute();
      break;
      default:

       return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('Error'),
          ),
        );
    });
  }

}