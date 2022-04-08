import 'package:dartz/dartz.dart';
import 'package:upload_percentage/core/errors/failures.dart';
import 'package:upload_percentage/features/users/data/models/response_general_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, ResponseGeneralModel>> updateUserPhotoDomainReps({Map parameters});
  Future<Either<Failure, ResponseGeneralModel>> getUserPhotoDomainReps({Map parameters});
}