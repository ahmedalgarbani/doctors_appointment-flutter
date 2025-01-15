import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:sqflite/sqflite.dart';

class DoctorDao {
  final Database _db;
  DoctorDao(this._db);

 
Future<List<DoctorModel>> getAllDoctors() async {
  final List<Map<String, Object?>> result = await _db.rawQuery('''
    SELECT doctors.*, specialties.name AS specialty_name
    FROM doctors
    INNER JOIN specialties
    ON doctors.specialty_id = specialties.id
    ORDER BY doctors.id DESC
  ''');

  return result.map((e) {
    return DoctorModel.fromMap(e); 
  }).toList();
}

  Future<void> insertDoctor(DoctorModel doctor) async {
    await _db.insert('doctors', doctor.toMap());
  }

  Future<void> updateDoctor(DoctorModel doctor) async {
    await _db.update('doctors', doctor.toMap(),
        where: 'id = ?', whereArgs: [doctor.id]);
  }

  Future<void> deleteDoctor(int id) async {
    await _db.delete('doctors', where: 'id = ?', whereArgs: [id]);
  }

}
