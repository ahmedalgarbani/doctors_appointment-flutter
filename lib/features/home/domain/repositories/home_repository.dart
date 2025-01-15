import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/features/home/data/models/specialist_model.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/doctor_model.dart';

abstract class HomeRepository{
    Future<List<DoctorModel>> getAllDoctors();
    Future<List<SpecialtyModel>> getAllSpecialites();
    Future<List<DoctorModel>> getAllFavourites(int patientId);
    Future<Either<Failure, void>> addNewFavorite({required int doctorId, required int patientId});
}