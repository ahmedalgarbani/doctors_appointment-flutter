import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/features/appointment/data/models/booking_model.dart';

import '../../../../core/services/api_service.dart';
import '../../domain/repositories/appointment_repo.dart';

class AppointmentRepoImpl implements AppointmentRepo {
  final ApiService _apiService = getIt.get<ApiService>();

  @override
  Future<Either<Failure, Map<String, List<BookingModel>?>>>
      getBookings() async {
    try {
      final upcomingBookings = await _fetchBookings(EndPoints.upcommingBooking);
      final historyBookings = await _fetchBookings(EndPoints.historyBooking);

      return Right({
        "upcoming": upcomingBookings,
        "history": historyBookings,
      });
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  Future<List<BookingModel>> _fetchBookings(String endpoint) async {
    try {
      Response response = await _apiService.get(endpoint);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data["results"];
        return BookingModel.fromJsonList(jsonList);
      } else {
        throw ServerFailure(errorMessage: "Failed to fetch bookings");
      }
    } on DioException catch (e) {
      log(" DioException: ${ServerFailure.fromDiorError(e)}");
      throw ServerFailure.fromDiorError(e);
    }
  }
}
