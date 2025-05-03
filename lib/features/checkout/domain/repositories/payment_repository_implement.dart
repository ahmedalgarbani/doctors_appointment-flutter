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
  Future<Either<Failure, void>> makeappointment(
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _apiService.post(
        EndPoints.createBooking,
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final booking = response.data;
        final paymentSuccess = await makeRelatedPayment(data: {
          "booking": booking["id"],
          "payment_method": booking['payment_method'],
          "payment_subtotal": booking['amount'],
          "payment_totalamount": booking['amount'],
          "payment_notes": "Paid from mobile app",
        });
        if (!paymentSuccess) {
          return Left(ServerFailure(errorMessage: "Payment failed"));
        }
        return const Right(null);
      } else {
        return Left(
          ServerFailure(
              errorMessage: 'Unexpected status: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(
        ServerFailure(
            errorMessage: e.response?.data.toString() ?? 'Unknown error'),
      );
    } catch (e) {
      log(ServerFailure(errorMessage: 'Something went wrong: $e').toString());
      return Left(
        ServerFailure.fromResponse(404, e),
      );
    }
  }

  Future<bool> makeRelatedPayment({required Map<String, dynamic> data}) async {
    try {
      final paymentData = {
        "booking": data['booking'],
        "payment_method": data['payment_method'],
        "payment_subtotal": data['payment_subtotal'],
        "payment_totalamount": data['payment_totalamount'],
        "payment_notes": "Paid from mobile app",
      };

      final response = await _apiService.post(
        EndPoints.payment,
        data: paymentData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        log("Payment  with status: Yessssss");
        return true;
      } else {
        log("Payment failed with status: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      log("DioException during payment: ${e.response?.data}");
      return false;
    } catch (e) {
      log("Unexpected error during payment: $e");
      return false;
    }
  }
}
