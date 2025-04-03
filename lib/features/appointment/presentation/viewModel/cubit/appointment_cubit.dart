
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/booking_model.dart';
import '../../../domain/repositories/appointment_repo.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo _appointmentRepo;

  AppointmentCubit(this._appointmentRepo) : super(AppointmentInitial());

  List<BookingModel> historyBookings = [];
  List<BookingModel> upcomingBookings = [];

  Future<void> getBookings() async {
    emit(AppointmentLoading());
    try {
      final result = await _appointmentRepo.getBookings();

      result.fold(
        (failure) {
          emit(AppointmentFailure(errorMessage: failure.errorMessage));
        },
        (bookings) {
          upcomingBookings = bookings["upcoming"] ?? [];
          historyBookings = bookings["history"] ?? [];

 
          emit(AppointmentSuccess(
            upcomingBookings: upcomingBookings,
            historyBookings: historyBookings,
          ));
        },
      );
    } catch (e) {
      emit(AppointmentFailure(errorMessage: e.toString()));
    }
  }
}
