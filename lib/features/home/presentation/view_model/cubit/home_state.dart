import 'package:equatable/equatable.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/specialist_model.dart';

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
  final List<DoctorModel> doctors;

  const HomeLoaded({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class SpecialtiesLoaded extends HomeState {
  final List<SpecialtyModel> specialties;

  const SpecialtiesLoaded({required this.specialties});

  @override
  List<Object> get props => [specialties];
}

class HomeLoadedWithSpecialties extends HomeState {
  final List<DoctorModel> doctors;
  final List<SpecialtyModel> specialties;

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
