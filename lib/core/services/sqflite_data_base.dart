import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/core/db/sqflite_db.dart';
import 'package:doctors_appointment/core/services/database_service.dart';
import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:doctors_appointment/features/home/data/models/specialist_model.dart';

import '../error/failure.dart';

class SqfliteDataBase implements DatabaseService {
  final DoctorAppointmentDatabase _appointmentDatabase;

  SqfliteDataBase(this._appointmentDatabase);
  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final doctorDao = await _appointmentDatabase.doctorDao();
    final allDoctors = await doctorDao.getAllDoctors();
    return allDoctors;
  }

  @override
  Future<List<SpecialtyModel>> getAllSpecialiest() async {
    final spicialDao = await _appointmentDatabase.specialistDao();
    final allSpecialist = await spicialDao.getAllSpecialites();
    return allSpecialist;
  }

  @override
  Future<List<DoctorModel>> getAllFavourites(int patientId) async {
    final favouritesDao = await _appointmentDatabase.favouritesDao();
    final favouritesDoctors = await favouritesDao.getAllFavourites(patientId);
    return favouritesDoctors;
  }

  @override
  Future<Either<Failure, void>> addNewFavorite(
      {required int doctorId, required int patientId}) async {
    if (patientId == 0) {
      Left(SqlFailure(message: "please login first"));
    }
    final favouriteDao = await _appointmentDatabase.favouritesDao();
     await favouriteDao.insertFavourites(
        doctorId: doctorId, patientId: patientId);
    return const Right(null);
  }
}
