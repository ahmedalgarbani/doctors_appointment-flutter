import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/core/services/get_it.dart';

import '../../../../core/services/api_service.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final ApiService _apiService = getIt.get<ApiService>();

  @override
  Future<Either<Failure, List<PaymentMethodModel>>> getPaymentMethods(
      {int? hospital}) async {

    try {
      Response response = await _apiService.post(
        EndPoints.getPaymentMethod,
        data: {"hospital_id": hospital},
      );
   
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<PaymentMethodModel> paymentMethods =
            data.map((json) => PaymentMethodModel.fromJson(json)).toList();

        return Right(paymentMethods);
      } else {
        return Left(ServerFailure(
            errorMessage: "Unexpected error: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return Left(
          ServerFailure(errorMessage: "Failed to fetch payment methods: $e"));
    }
  }

  
  @override
  Future<Either<Failure, List<PaymentMethodModel>>> makePayment() {
    // TODO: implement makePayment
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, void>> makeappointment({Map<String, dynamic>? data}) async{
  try {
    log(data.toString());
    final response = await _apiService.post(
      EndPoints.createBooking,
      data: data,
    );
       log(response.toString());
      log(response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
     
      return Right(response.data);
    } else {
      return Left(ServerFailure(errorMessage:  'Unexpected status: ${response.statusCode}'));
    }
  } on DioException catch (e) {
    return Left(ServerFailure(errorMessage:  e.response?.data.toString() ?? 'Unknown error'));
  } catch (e) {
    log(e.toString());
    log(ServerFailure(errorMessage:  'Something went wrong: $e').toString());
    return Left(ServerFailure.fromResponse( 404, e));
  }

  }
}
