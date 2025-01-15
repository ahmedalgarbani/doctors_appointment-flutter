import '../../data/model/create_user_request.dart';
import '../../data/model/signin_user_request.dart';

abstract class AuthRepository {
  Future<void> createUserWithEmailAndPassword({required Patient patient});

  Future<Patient> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest});

  Future<int?> getAuthUserId();

  Future<void> setAuthUserId(int userId);

  Future<void> logout();
}
