import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/core/services/database_service.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/get_it.dart';
import '../models/speciality_response/doctor.dart';
import '../models/speciality_response/speciality_response.dart';

class HomeServicesApi extends DatabaseService {
  @override
  Future<Either<Failure, bool>> addNewFavorite({required int doctorId}) async {
    try {
      var result = await getIt
          .get<ApiService>()
          .post(EndPoints.favorites, data: {"doctor": doctorId});

      return Right(true);
    } catch (e) {
      return Left(
        ServerFailure(errorMessage: "Error Occure while add favorite"),
      );
    }
  }

  @override
  Future<List<Doctor>?> getAllFavourites() async {
    try {
      Response response =
          await getIt.get<ApiService>().get(EndPoints.favorites);
      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('results')) {
        List<dynamic> results = response.data['results'];
        List<Doctor>? result =
            results.map((e) => Doctor.fromMap(e['doctor_data'])).toList();

        return result;
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<SpecialityResponse>> getAllSpecialiest() async {
    try {
      var response = await getIt.get<ApiService>().get(EndPoints.specialties);

      if (response.data is Map<String, dynamic> &&
          response.data.containsKey('results')) {
        List<dynamic> results = response.data['results'];

        return results.map((e) => SpecialityResponse.fromMap(e)).toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  @override
  Future<bool> isFavorite({required int doctorId, required int patientId}) {
    // TODO: implement isFavorite
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFavorite({required int doctorId}) {
    try {
      getIt
          .get<ApiService>()
          .delete(EndPoints.removeFavorites, data: {"doctor": doctorId});
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
