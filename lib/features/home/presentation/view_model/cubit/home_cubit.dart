import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/features/home/data/models/specialist_model.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import '../../../data/models/doctor_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  List<DoctorModel> allDoctors = [];
  List<SpecialtyModel> allSpecialties = [];

  Future<void> getAllDoctors() async {
    emit(HomeLoading());
    try {
      allDoctors = await _homeRepository.getAllDoctors();
      emit(HomeLoaded(doctors: allDoctors));
    } catch (e) {
      emit(HomeFailure("Failed to fetch doctors: ${e.toString()}"));
    }
  }

  Future<void> getAllSpecialties() async {
    emit(HomeLoading());
    try {
      allSpecialties = await _homeRepository.getAllSpecialites();
      emit(SpecialtiesLoaded(specialties: allSpecialties));
    } catch (e) {
      emit(HomeFailure("Failed to fetch specialties: ${e.toString()}"));
    }
  }

  Future<void> getHomeFeatures() async {
    emit(HomeLoading());

    try {
      final doctorsFuture = getAllDoctors();
      final specialtiesFuture = getAllSpecialties();

      await Future.wait([
        doctorsFuture.catchError((_) {}),
        specialtiesFuture.catchError((_) {}),
      ]);

      emit(HomeLoadedWithSpecialties(
          doctors: allDoctors, specialties: allSpecialties));
    } catch (e) {
      emit(HomeFailure("Failed to fetch home features: ${e.toString()}"));
    }
  }
}
