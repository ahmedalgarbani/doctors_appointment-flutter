import 'package:sqflite/sqflite.dart';

import '../../features/home/data/models/speciality_response/doctor.dart';

class DoctorDao {
  final Database _db;
  DoctorDao(this._db);

  Future<List<Doctor>> getAllDoctors() async {
    final List<Map<String, Object?>> result = await _db.rawQuery('''
    SELECT doctors.*, specialties.name AS specialty_name
    FROM doctors
    INNER JOIN specialties
    ON doctors.specialty_id = specialties.id
    ORDER BY doctors.id DESC
  ''');

    return result.map((e) {
      return Doctor.fromMap(e);
    }).toList();
  }

  Future<void> insertDoctor(Doctor doctor) async {
    await _db.insert('doctors', doctor.toMap());
  }

  Future<void> updateDoctor(Doctor doctor) async {
    await _db.update('doctors', doctor.toMap(),
        where: 'id = ?', whereArgs: [doctor.id]);
  }

  Future<void> deleteDoctor(int id) async {
    await _db.delete('doctors', where: 'id = ?', whereArgs: [id]);
  }
}
