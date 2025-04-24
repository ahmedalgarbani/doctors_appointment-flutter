import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/payment_method_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure,List<PaymentMethodModel>>> getPaymentMethods({int? hospital});
  Future<Either<Failure,List<PaymentMethodModel>>> makePayment();
  Future<Either<Failure,void>> makeappointment({Map<String, dynamic> data});
}