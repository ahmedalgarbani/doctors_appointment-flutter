part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final List<BookingModel>? historyBookings;
  final List<BookingModel>? upcomingBookings;

  AppointmentSuccess({required this.historyBookings, required this.upcomingBookings});
}

class AppointmentFailure extends AppointmentState {
  final String errorMessage;

  AppointmentFailure({required this.errorMessage});

}
