import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/speciality_response/speciality_response.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Doctor> doctors;

  const HomeLoaded({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class SpecialtiesLoaded extends HomeState {
  final List<SpecialityResponse> specialties;

  const SpecialtiesLoaded({required this.specialties});

  @override
  List<Object> get props => [specialties];
}
class DoctorsLoaded extends HomeState {
  final List<Doctor> doctors;

  const DoctorsLoaded({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class HomeLoadedWithSpecialties extends HomeState {
  final List<Doctor> doctors;
  final List<SpecialityResponse> specialties;

  const HomeLoadedWithSpecialties(
      {required this.doctors, required this.specialties});

  @override
  List<Object> get props => [doctors, specialties];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}
