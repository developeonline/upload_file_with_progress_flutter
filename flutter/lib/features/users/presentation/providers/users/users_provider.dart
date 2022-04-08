import 'package:upload_percentage/core/enum/upload_status.dart';
import 'package:upload_percentage/core/errors/failures.dart';
import 'package:upload_percentage/features/users/data/models/response_general_model.dart';
import 'package:upload_percentage/features/users/data/repositories/users_repository_impl.dart';
import 'package:upload_percentage/features/users/domain/entities/personal_pic.dart';
import '../../../../../core/enum/viewstate.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../base_provider.dart';
import '../../../../../injection_container.dart';

class UsersProvider extends BaseProvider{
  var data;
  bool _operationStatus;
  UploadStatus _uploadStatus;
  double progressProgress;

  UploadStatus get uploadStatus => _uploadStatus;
  String _returnedMessage;
  PersonalPic _currentPersonalPic;

  // getters
  bool get operationStatus => _operationStatus;
  String get returnedMessage => _returnedMessage;
  PersonalPic get currentPersonalPic => _currentPersonalPic;


  UsersRepositoryImpl _usersControlRepositoryImpl  = sl<UsersRepositoryImpl>();

  updateUserPhoto({Map parameters, bool shouldUpdate = true}) async {
    try {
      cleanUp();
      this._uploadStatus = UploadStatus.fetchingUpload;
      Either<Failure, ResponseGeneralModel> failureOrUsers = await _usersControlRepositoryImpl
          .updateUserPhotoDomainReps(parameters: parameters);
      this._uploadStatus = UploadStatus.uploading;
      if (failureOrUsers.isRight()) {
        failureOrUsers.foldRight(ResponseGeneralModel, (r, previous) {
          this._returnedMessage = r.message;
          this._operationStatus = r.success;
          this._uploadStatus = UploadStatus.uploaded;
          _currentPersonalPic = PersonalPic.fromJson(r.data);
        });
        setCurrentState(viewState: ViewState.Idle, shouldUpdate: shouldUpdate);

      } else if (failureOrUsers.isLeft()) {
        final result = failureOrUsers.fold(
                (failure) => failure,
                (data) => ResponseGeneralModel
        );

        this._operationStatus = false;
        this._uploadStatus = UploadStatus.notUploaded;

        if (result is NetworkFailure) {} else
        if (result is ServerFailure) {} else
        if (result is UpdateUserPhotoFailure) {}

        setCurrentState(viewState: ViewState.Error, shouldUpdate: shouldUpdate);
      }
    } on UpdateUserPhotoFailure catch (e) {
      debugPrint('UpdateUserPhotoFailure $e');
    }
  }

  getUserPhoto({Map parameters, bool shouldUpdate = true}) async {
    try{
      cleanUp();
      Either<Failure, ResponseGeneralModel> failureOrUsers = await _usersControlRepositoryImpl.getUserPhotoDomainReps(parameters: parameters);
      if(failureOrUsers.isRight()){
        failureOrUsers.foldRight(PersonalPic, (r, previous) {
          _returnedMessage=r.message;
          this._operationStatus = r.success;
          this._currentPersonalPic = PersonalPic.fromJson(r.data);
        });
        setCurrentState(viewState: ViewState.Idle, shouldUpdate: shouldUpdate);
      } else if(failureOrUsers.isLeft()){
        final result = failureOrUsers.fold(
                (failure) => failure,
                (data) => ResponseGeneralModel
        );
        this._operationStatus = false;
        if(result is NetworkFailure){
        } else if(result is ServerFailure){
        } else if(result is GetUserPhotoFailure){
        }
        setCurrentState(viewState: ViewState.Error, shouldUpdate: shouldUpdate);
      }
    } on GetUserPhotoFailure catch (e) {
      debugPrint('GetUserPhotoFailure $e');
    }
  }


  void cleanUp() async{
    data = null;
    _currentPersonalPic=null;
    _operationStatus = false;
    _returnedMessage=null;
    _uploadStatus = null;
  }


}