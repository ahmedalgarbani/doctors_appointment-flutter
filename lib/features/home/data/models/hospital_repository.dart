import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/models/hospital_model.dart';
import 'package:doctors_appointment/core/services/api_service.dart';

class HospitalRepository {
  final ApiService apiService;

  HospitalRepository({required this.apiService});

  Future<Either<Failure, List<Hospital>>> getDoctorHospitals(int doctorId) async {
    try {
      final response = await apiService.get('/doctors/$doctorId/hospitals/');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final hospitals = data.map((json) => Hospital.fromJson(json)).toList();
        return Right(hospitals);
      } else {
        return Left(ServerFailure(
          errorMessage: 'Failed to load hospitals: ${response.statusCode}'
        ));
      }
    } on FormatException catch (e) {
      return Left(ServerFailure(errorMessage: 'Data parsing error: ${e.message}'));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'Unexpected error: ${e.toString()}'));
    }
  }
}
