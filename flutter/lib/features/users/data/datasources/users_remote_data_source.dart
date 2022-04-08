import 'package:upload_percentage/core/errors/exceptions.dart';
import 'package:upload_percentage/core/util/helper_function.dart';
import 'package:upload_percentage/features/users/data/models/response_general_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/util/constants.dart';
import '../../../../../injection_container.dart';

abstract class UsersRemoteDataSource{
  Future<ResponseGeneralModel> getUserPhotoRDSource({Map parameters});
  Future<ResponseGeneralModel> updateUserPhotoRDSource({Map parameters});
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource{

  // or new Dio with a BaseOptions instance.
  Map<String, dynamic> headersMap({String token}){
    return {
      'Content-Type': 'application/json',
      'Authorization': token != null ? "Bearer "+token.toString() : "",
      'api-key': Constants.APP_API_KEY,
    };
  }

  Options options({String token, String lang}) => new Options(
    receiveDataWhenStatusError: true,
    sendTimeout: 5000,
    receiveTimeout: 3000,
    headers: headersMap(token: token,),
  );
  Dio client  = sl<Dio>();

  final String _baseUrl = Constants.API_BASE_URL;
  UsersRemoteDataSourceImpl({@required this.client}){
    //  this.dioCertificate();
  }

  @override
  Future<ResponseGeneralModel> getUserPhotoRDSource({Map parameters}) {
    // TODO: implement getUserPhotoRDSource
    throw UnimplementedError();
  }

  @override
  Future<ResponseGeneralModel> updateUserPhotoRDSource({Map parameters}) async {
    String query = '$_baseUrl'+Constants.UPDATE_USER_PHOTO;
    String token = await getToken();
    debugPrint('token: $token');
    debugPrint('query $query');
    if(token == null || token.isEmpty) {
      throw UserUnAuthorisedException();
    }
    try{
      debugPrint('updateUserPhotoRDSource parameters = ${parameters}');
      var formData = FormData.fromMap({
        'id': parameters['id'],
        'name': parameters['name'],
        'updated_at': parameters['updated_at'],
        //'photo': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
        'photo': await MultipartFile.fromFile('${parameters['photo']}', filename: 'medomedo.png'),
      });

      final response = await client.post('$query', data: formData,
          options: this.options(token: token),
          onSendProgress: (int sent, int total) {
            debugPrint('progress: ${(sent / total * 100).toStringAsFixed(
                0)}% ($sent/$total)');
            if(sent == total){
              debugPrint('upload photo done!');
            }

          }
      );
      debugPrint('response $response');
      if(response.statusCode == 200){
        return ResponseGeneralModel.fromJson(response.data);
      }
      throw UpdateUserPhotoException();
    } on DioError catch (ex) {
      debugPrint("DioError Exception occured: ${ex}");
     if(ex.response.statusCode == 404){
        throw UserNotFoundException();
      } else if(ex.response.statusCode == 401){
        throw UserUnAuthorisedException();
      } else {
        throw NetworkException();
      }
    } catch (error, stacktrace) {

      debugPrint("Exception occured: $error stackTrace: $stacktrace");

      throw NetworkException();

    }
  }





} 