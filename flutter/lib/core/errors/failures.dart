abstract class Failure {
  Failure([List properties = const <dynamic>[]]);
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Failure;
  }
}

class ServerFailure extends Failure {}
class NetworkFailure extends Failure {}
class GetUserPhotoFailure extends Failure {}
class UpdateUserPhotoFailure extends Failure {}
class UserNotFoundFailure extends Failure {}
class UserUnAuthorisedFailure extends Failure {}