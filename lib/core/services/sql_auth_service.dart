import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import '../constant/constant.dart';
import '../db/sqflite_db.dart';
import '../error/failure.dart';
import '../../features/auth/data/model/signin_user_request.dart';
import '../../features/auth/data/sources/auth_service.dart';

class SqfliteAuthServiceImple extends AuthService {
  final DoctorAppointmentDatabase _doctorAppointmentDatabase;

  SqfliteAuthServiceImple(this._doctorAppointmentDatabase);

  @override
  Future deleteUser(int id) async {
    var authDao = await _doctorAppointmentDatabase.authDao();
    authDao.deletePatient(id);
  }

  @override
  Future<Either<Failure, Patient>> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) async {
    if (signinUserRequest.password.length < 6) {
      throw SqlFailure(
          errorMessage: 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.');
    }

    try {
      var authDao = await _doctorAppointmentDatabase.authDao();
      var result = await authDao.getPatient(
          email: signinUserRequest.email, password: signinUserRequest.password);
      Pref.setInt(KauthUserId, result?.id ?? 0);
      return Right(result!);
    } catch (e) {
      throw SqlFailure(errorMessage: 'حدث خطأ أثناء إنشاء المستخدم.');
    }
  }

  @override
  Future<Either<ServerFailure, dynamic>> createUserWithEmailAndPassword(
      {required Patient patient}) async {
    if (patient.password!.length < 6) {
      throw SqlFailure(
          errorMessage: 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.');
    }
    try {
      var authDao = await _doctorAppointmentDatabase.authDao();
      await authDao.insertPatient(patient);
      return Right("User registration successful");
    } catch (e) {
      throw SqlFailure(errorMessage: 'حدث خطأ أثناء إنشاء المستخدم.');
    }
  }

  @override
  Future<int?> getAuthUserId() async {
    return await Pref.getInt(KauthUserId);
  }

  @override
  Future<void> setAuthUserId(int userId) async {
    await Pref.setInt(KauthUserId, userId);
    await Pref.setBool(KIsLogin, true);
  }

  @override
  Future<bool> logout() async {
    try {
      await Pref.setInt(KauthUserId, 0);
      await Pref.setBool(KIsLogin, false);
      return true;
    } catch (e) {
      return false;
    }
  }
}
