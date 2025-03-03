import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:doctors_appointment/features/auth/data/model/signin_user_request.dart';
import 'package:doctors_appointment/features/auth/data/sources/auth_service.dart';

import '../../../../core/error/failure.dart';

class FireBaseAuthService extends AuthService {
  @override
  Future<Either<Failure,dynamic>> createUserWithEmailAndPassword({required Patient patient}) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,Patient>> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) {
    // TODO: implement signinUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<int?> getAuthUserId() {
    // TODO: implement getAuthUserId
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> setAuthUserId(int userId) {
    // TODO: implement setAuthUserId
    throw UnimplementedError();
  }
}
