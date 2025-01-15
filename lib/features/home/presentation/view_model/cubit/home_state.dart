import 'package:equatable/equatable.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/models/specialist_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DoctorModel> doctors;

  const HomeLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

class HomeLoadedWithSpecialties extends HomeState {
  final List<DoctorModel> doctors;
  final List<SpecialtyModel> specialties;

  HomeLoadedWithSpecialties(this.doctors, this.specialties);

  @override
  List<Object> get props => [doctors, specialties];
}


class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}
