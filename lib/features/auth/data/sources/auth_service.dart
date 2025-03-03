import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import '../../../../core/error/failure.dart';
import '../model/signin_user_request.dart';

abstract class AuthService {
  Future<void> createUserWithEmailAndPassword({required Patient patient});

  Future<Either<Failure,Patient>> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest});
  Future deleteUser(int id);
  Future<int?> getAuthUserId();

  Future<void> setAuthUserId(int userId);

  Future<bool> logout();
}
