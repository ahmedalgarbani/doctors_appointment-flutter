import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/booking_model.dart';

abstract class AppointmentRepo {
  Future<Either<Failure,Map<String,List<BookingModel>?>>> getBookings();
}