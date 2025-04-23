import 'package:sqflite/sqflite.dart';
import '../../features/home/data/models/specialist_model.dart';

class SpecialistDao {
  final Database _db;
  SpecialistDao(this._db);

  Future<List<SpecialtyModel>> getAllSpecialites() async {
    final List<Map<String, Object?>> result =
        await _db.query('specialties', orderBy: 'id DESC');
    return result.map((e) => SpecialtyModel.fromMap(e)).toList();
  }

  Future<int> insertSpecialty(SpecialtyModel specialty) async {
    return await _db.insert('specialties', specialty.toMap());
  }

  Future<int> updateSpecialty(SpecialtyModel Specialist) async {
    return await _db.update('specialties', Specialist.toMap(),
        where: 'id = ?', whereArgs: [Specialist.id]);
  }

  Future<int> deleteSpecialty(int id) async {
    return await _db.delete('specialties', where: 'id = ?', whereArgs: [id]);
  }
}
