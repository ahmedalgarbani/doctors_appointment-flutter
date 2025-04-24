
import 'package:dartz/dartz.dart';

import '../../features/home/data/models/speciality_response/doctor.dart';
import '../../features/home/data/models/speciality_response/speciality_response.dart';
import '../error/failure.dart';

abstract class DatabaseService {
  // Future<Either<Failure, void>> SignupWithEmailAndPassword(Patient user);
  // Future<Either<Failure, void>> SigninWithEmailAndPassword(UserEntil user);
  Future<List<SpecialityResponse>> getAllSpecialiest();
  Future<List<Doctor>?> getAllFavourites();
  Future<Either<Failure, bool>> addNewFavorite({required int doctorId});
  Future<bool> removeFavorite({required int doctorId});
  Future<bool> isFavorite({required int doctorId, required int patientId});
}
