import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/home/data/models/speciality_response/doctor.dart';

class FavouritesDao {
  final Database _db;
  FavouritesDao(this._db);

  Future<List<Doctor>> getAllFavourites(int patientId) async {
    final List<Map<String, Object?>> result = await _db.rawQuery('''
    SELECT doctors.*, patient_id AS patientId,specialties.name AS specialty_name
    FROM favourites
    INNER JOIN doctors ON favourites.doctor_id = doctors.id
    INNER JOIN specialties ON doctors.specialty_id = specialties.id
    WHERE favourites.patient_id = ?
    ORDER BY doctors.id DESC
  ''', [patientId]);

    return result.map((e) {
      return Doctor.fromMap(e);
    }).toList();
  }

  Future<void> insertFavourites(
      {required int doctorId, required int patientId}) async {
    final List<Map<String, dynamic>> existing = await _db.query(
      'favourites',
      where: 'doctor_id = ? AND patient_id = ?',
      whereArgs: [doctorId, patientId],
    );

    if (existing.isNotEmpty) {
      throw Exception("This doctor is already in the favorites.");
    }
    await _db.insert(
      'favourites',
      {
        'doctor_id': doctorId,
        'patient_id': patientId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> updateFavourites(Doctor doctor) async {
    await _db.update('favourites', doctor.toMap(),
        where: 'id = ?', whereArgs: [doctor.id]);
  }

  Future<void> deleteFavourites(
      {required int doctorId, required int patientId}) async {
    final result = await _db.delete(
      'favourites',
      where: 'doctor_id = ? AND patient_id = ?',
      whereArgs: [doctorId, patientId],
    );
    print(result);
  }

  Future<bool> isFavorite(
      {required int doctorId, required int patientId}) async {
    final List<Map<String, dynamic>> existing = await _db.query(
      'favourites',
      where: 'doctor_id = ? AND patient_id = ?',
      whereArgs: [doctorId, patientId],
    );
    return existing.isNotEmpty;
  }
}
