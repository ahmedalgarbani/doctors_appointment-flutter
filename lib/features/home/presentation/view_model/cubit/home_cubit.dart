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
    try {
      emit(HomeLoading());
      allDoctors = await _homeRepository.getAllDoctors();
    } catch (e) {
      emit(HomeFailure("Failed to fetch doctors: ${e.toString()}"));
      return; 
    }
  }

  Future<void> getAllSpecialties() async {
    try {
      emit(HomeLoading());
      allSpecialties = await _homeRepository.getAllSpecialites();
    } catch (e) {
      emit(HomeFailure("Failed to fetch specialties: ${e.toString()}"));
      return; 
    }
  }

  Future<void> getHomeFeatures() async {
    try {
      emit(HomeLoading());
      
      await Future.wait([getAllDoctors(), getAllSpecialties()]);

      emit(HomeLoadedWithSpecialties(allDoctors, allSpecialties));
    } catch (e) {
      emit(HomeFailure("Failed to fetch home features: ${e.toString()}"));
    }
  }
}

