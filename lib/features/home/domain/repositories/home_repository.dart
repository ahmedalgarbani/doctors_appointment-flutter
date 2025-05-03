import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/review_request.dart';
import '../../data/models/speciality_response/doctor.dart';
import '../../data/models/speciality_response/review.dart';
import '../../data/models/speciality_response/speciality_response.dart';

abstract class HomeRepository {
  Future<List<SpecialityResponse>> getAllSpecialites();
  Future<List<Doctor>?> getAllFavourites();
  
  Future<Either<Failure, bool>> addNewFavorite(
      {required int doctorId});
  Future<bool> deleteFavorite({
    required int doctorId,
  });
  Future<bool> isFavorite({
    required int doctorId,
    required int patientId,
  });
  Future<Review?> addReview({required ReviewRequest review});
}
