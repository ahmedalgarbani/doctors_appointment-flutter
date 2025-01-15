import 'package:doctors_appointment/features/home/data/models/doctor_model.dart';

import '../../features/home/data/models/specialist_model.dart';

abstract class DatabaseService {
  // Future<Either<Failure, void>> SignupWithEmailAndPassword(Patient user);
  // Future<Either<Failure, void>> SigninWithEmailAndPassword(UserEntil user);
  Future<List<DoctorModel>> getAllDoctors();
  Future<List<SpecialtyModel>> getAllSpecialiest();
  Future<List<DoctorModel>> getAllFavourites(int patientId);
  Future<void> addNewFavorite({required int doctorId, required int patientId});
}
