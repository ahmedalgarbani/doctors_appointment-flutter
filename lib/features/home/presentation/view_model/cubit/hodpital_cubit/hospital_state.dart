part of 'hospital_cubit.dart';

abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<Hospital> hospitals;

  HospitalLoaded(this.hospitals);
}

class HospitalError extends HospitalState {
  final String message;

  HospitalError(this.message);
}