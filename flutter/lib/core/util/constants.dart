import 'dart:convert';

import 'dart:io';

class Constants  {
  static final String APP_EMAIL = 'test@gmail.com';
  static final String APP_DOMAIN = 'http://192.168.1.90/generic_app';
  static final String BASE_URL = "http://192.168.1.90/generic_app/";
  static final String APP_API_KEY='878787';
  // configuration constants
  static final String APP_TOKEN_VALUE = 'testingAppTesting';
  static final String APP_TOKEN_KEY = 'APP_TOKEN_KEY';
  static final String FIRST_OPEN_FALG = 'FIRST_OPEN_FALG';
  static final String HomeRoute = '/home';

  //static String API_BASE_URL= 'http://192.168.1.90/generic_app';
  static String API_BASE_URL= 'https://genericappsss.000webhostapp.com';
  static final String USER_PHOTOS_PATH = Constants.BASE_URL+"public/storage/";
  static final String IMAGE_RESOURCES_PATH = 'app';
  static final String DEFAULT_USER_IMAGE = 'assets/images/default_user.png';
  // screen routing
  static final String HomeScreenRoute = '/home';
  static final String UpdateUserPhotoRoute = '/update_user_photo';

  // Api Routes
  static final String UPDATE_USER_PHOTO="/cust_api.php";



  static const String TOKEN_KEY ='token';
// User fields
  static const String USER_ID_KEY ='id';
  static const String USER_NAME_KEY ='name';
  static const String CREATED_AT_KEY ='created_at';
  static const String UPDATED_AT_KEY ='updated_at';
  static const String USER_PHOTO_KEY ='photo';




}