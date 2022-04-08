import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:upload_percentage/core/errors/exceptions.dart';
import 'package:upload_percentage/core/errors/failures.dart';
import 'package:upload_percentage/features/users/data/datasources/users_local_data_source.dart';
import 'package:upload_percentage/features/users/data/datasources/users_remote_data_source.dart';
import 'package:upload_percentage/features/users/data/models/response_general_model.dart';
import 'package:upload_percentage/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  UsersRemoteDataSource remoteDataSource;
  UsersLocalDataSource localDataSource;

  UsersRepositoryImpl({
    this.remoteDataSource,
    this.localDataSource,
  });

  @override
  Future<Either<Failure, ResponseGeneralModel>> getUserPhotoDomainReps({Map parameters}) {
    // TODO: implement getUserPhotoDomainReps
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseGeneralModel>> updateUserPhotoDomainReps({Map parameters})  async {
      try {
        final result = await remoteDataSource.updateUserPhotoRDSource(parameters: parameters);
        if (result != null && result.success == true && result != null) {
          return Right(result);
        }

      } on NetworkException {
        return Left(NetworkFailure());
      } on UpdateUserPhotoException {
        return Left(UpdateUserPhotoFailure());
      } on UserUnAuthorisedException {
        return Left(UserUnAuthorisedFailure());
      } catch (e){
        debugPrint('updateUserPhotoDomainReps error: $e');
        return Left(UpdateUserPhotoFailure());
      }
      return Left(UpdateUserPhotoFailure());
  }


}
