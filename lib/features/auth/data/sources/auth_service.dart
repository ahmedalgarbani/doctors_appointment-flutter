import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/db/sqflite_db.dart';
import '../../../../core/error/failure.dart';
import '../model/signin_user_request.dart';

abstract class AuthService {
  Future<void> createUserWithEmailAndPassword({required Patient patient});

  Future<Patient> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest});
  Future deleteUser(int id);
  Future<int?> getAuthUserId();

  Future<void> setAuthUserId(int userId);

  Future<void> logout();
}

class SqfliteAuthServiceImple extends AuthService {
  final DoctorAppointmentDatabase _doctorAppointmentDatabase;

  SqfliteAuthServiceImple(this._doctorAppointmentDatabase);

  @override
  Future deleteUser(int id) async {
    var authDao = await _doctorAppointmentDatabase.authDao();
    authDao.deletePatient(id);
  }

  @override
  Future<Patient> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) async {
    if (signinUserRequest.password.length < 6) {
      throw SqlFailure(
          message: 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.');
    }

    try {
      var authDao = await _doctorAppointmentDatabase.authDao();
      var result = await authDao.getPatient(
          email: signinUserRequest.email, password: signinUserRequest.password);
      Pref.setInt(KauthUserId, result?.id ?? 0);
      return result!;
    } catch (e) {
      throw SqlFailure(message: 'حدث خطأ أثناء إنشاء المستخدم.');
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      {required Patient patient}) async {
    if (patient.password.length < 6) {
      throw SqlFailure(
          message: 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.');
    }

    try {
      var authDao = await _doctorAppointmentDatabase.authDao();
      await authDao.insertPatient(patient);
    } catch (e) {
      throw SqlFailure(message: 'حدث خطأ أثناء إنشاء المستخدم.');
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
  Future<void> logout() async {
    await Pref.setInt(KauthUserId, 0);
    await Pref.setBool(KIsLogin,false);
  }
}
