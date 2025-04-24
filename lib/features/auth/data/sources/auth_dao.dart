import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:sqflite/sqflite.dart';

class AuthDao {
  final Database _db;
  AuthDao(this._db);

  Future<int> insertPatient(Patient patient) async {
    return await _db.insert('patients', patient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Patient?> getPatient(
      {required String email, required String password}) async {
    try {
      final result = await _db.query(
        'patients',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result.isNotEmpty) {
        return Patient.fromMap(result.first);
      } else {
        return null;
      }
    } catch (e) {

      return null;
    }
  }

  Future<int> deletePatient(int id) async {
    return await _db.delete('patients', where: 'id = ?', whereArgs: [id]);
  }
}
