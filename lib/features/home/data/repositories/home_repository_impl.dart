import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/core/services/database_service.dart';
import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';
import 'package:doctors_appointment/features/home/data/models/specialist_model.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class HomeRepositoryImpl extends HomeRepository {
  final DatabaseService _databaseService;

  HomeRepositoryImpl(this._databaseService);
  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    return await _databaseService.getAllDoctors();
  }

  @override
  Future<List<SpecialtyModel>> getAllSpecialites() async {
    return await _databaseService.getAllSpecialiest();
  }

  @override
  Future<List<DoctorModel>> getAllFavourites(int patientId) async {
    return await _databaseService.getAllFavourites(patientId);
  }

  @override
  Future<Either<Failure, void>> addNewFavorite({
    required int doctorId,
    required int patientId,
  }) async {
    try {
      await _databaseService.addNewFavorite(
        doctorId: doctorId,
        patientId: patientId,
      );
      return const Right(null);
    } catch (e) {
      return Left(SqlFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> deleteFavorite(
      {required int doctorId, required int patientId}) async {
    var result = await _databaseService.removeFavorite(
        doctorId: doctorId, patientId: patientId);
    return result;
  }

  Future<bool> isFavorite(
      {required int doctorId, required int patientId}) async {
    var result = await _databaseService.isFavorite(
        doctorId: doctorId, patientId: patientId);
    
    return result;
  }
}
