import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/core/services/database_service.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';
import '../models/speciality_response/doctor.dart';
import '../models/speciality_response/speciality_response.dart';

class HomeRepositoryImpl extends HomeRepository {
  final DatabaseService _databaseService;

  HomeRepositoryImpl(this._databaseService);

  @override
  Future<List<SpecialityResponse>> getAllSpecialites() async {
    return await _databaseService.getAllSpecialiest();
  }

  @override
  Future<List<Doctor>?> getAllFavourites() async {
    return await _databaseService.getAllFavourites();
  }

  @override
  Future<Either<Failure, bool>> addNewFavorite({
    required int doctorId,
  }) async {
    try {
      await _databaseService.addNewFavorite(
        
        doctorId: doctorId,
      );
      return const Right(true);
    } catch (e) {
      return Left(SqlFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<bool> deleteFavorite(
      {required int doctorId}) async {
    var result = await _databaseService.removeFavorite(
        doctorId: doctorId);
    return result;
  }

  Future<bool> isFavorite(
      {required int doctorId, required int patientId}) async {
    var result = await _databaseService.isFavorite(
        doctorId: doctorId, patientId: patientId);

    return result;
  }
}
