import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';
import 'constants.dart';
import 'package:upload_percentage/injection_container.dart' as di;

getToken() async{
  final storage = FlutterSecureStorage();
  return await storage.read(key: Constants.TOKEN_KEY);
}

Future<void> storeToken({String token}) async{
  final storage = FlutterSecureStorage();
  storage.write(key: Constants.TOKEN_KEY, value: token);
}

Future<User> getUserReferences() async{
  final storage = FlutterSecureStorage();
  String id = await storage.read(key: Constants.USER_ID_KEY);
  String name = await storage.read(key: Constants.USER_NAME_KEY);
  String photo = await storage.read(key: Constants.USER_PHOTO_KEY);
  String createdAt = await storage.read(key: Constants.CREATED_AT_KEY);
  String updatedAt = await storage.read(key: Constants.UPDATED_AT_KEY);

  return User(
      id: id != null ? int.tryParse(id) : null,
      name: name,
      photo: photo,
      createdAt: createdAt,
      updatedAt: updatedAt
  );
}


Future<void> storeUserData({User user}) async{
  //debugPrint('storeUserData protected storage user');
  try {
    final storage = FlutterSecureStorage();
    storage.write(key: Constants.USER_ID_KEY, value: user.id.toString());
    storage.write(key: Constants.USER_NAME_KEY, value: user.name);
    storage.write(key: Constants.USER_PHOTO_KEY, value: user.photo);
    storage.write(key: Constants.CREATED_AT_KEY, value: user.createdAt);
    storage.write(key: Constants.UPDATED_AT_KEY, value: user.updatedAt);
  } catch (e) {
    print(e);
  }
}