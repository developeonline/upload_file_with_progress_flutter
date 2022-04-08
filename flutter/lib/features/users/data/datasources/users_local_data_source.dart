import 'package:upload_percentage/features/users/data/models/response_local_general_model.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';
import '../../../../../core/db/database_user_helper.dart';

abstract class UsersLocalDataSource{
  Future<ResponseLocalGeneralModel> updateLocalUserPhotoLDSource({User user});
}

class UsersLocalDataSourceImpl implements UsersLocalDataSource{
  final UserDatabaseHelper databaseHelper;
  UsersLocalDataSourceImpl({this.databaseHelper});

  @override
  Future<ResponseLocalGeneralModel> updateLocalUserPhotoLDSource({User user}) {
    // TODO: implement updateLocalUserPhotoLDSource
    throw UnimplementedError();
  }



} 