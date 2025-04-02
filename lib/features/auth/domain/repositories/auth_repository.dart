import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/create_user_request.dart';
import '../../data/model/signin_user_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, dynamic>> createUserWithEmailAndPassword(
      {required Patient patient});

  Future<Either<Failure, Patient>> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest});

  Future<int?> getAuthUserId();

  Future<void> setAuthUserId(int userId);

  Future<bool> logout();
}
