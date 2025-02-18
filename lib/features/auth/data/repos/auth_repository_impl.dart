import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:doctors_appointment/features/auth/data/sources/auth_service.dart';

import '../../domain/repositories/auth_repository.dart';
import '../model/signin_user_request.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);
  @override
  Future<void> createUserWithEmailAndPassword(
      {required Patient patient}) async {
    return await _authService.createUserWithEmailAndPassword(patient: patient);
  }

  @override
  Future<Patient> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) async {
    return await _authService.signinUserWithEmailAndPassword(
        signinUserRequest: signinUserRequest);
  }

  Future<int?> getAuthUserId() async {
    return await _authService.getAuthUserId();
  }

  Future<void> setAuthUserId(int userId) async {
    return await _authService.setAuthUserId(userId);
  }

  Future<bool> logout() async {
    return await _authService.logout();
  }
}
