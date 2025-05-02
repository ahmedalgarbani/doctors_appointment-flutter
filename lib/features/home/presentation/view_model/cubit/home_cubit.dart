
import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import '../../../data/models/speciality_response/speciality_response.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  List<Doctor> allDoctors = [];
  List<SpecialityResponse> allSpecialties = [];

  Future<void> getAllDoctors({int id = -1}) async {
    emit(HomeLoading());
    try {
      allDoctors = [];
      if (id < 0) {
        allSpecialties.forEach((speciality) {
          if (speciality.doctors != null) {
            allDoctors.addAll(speciality.doctors!);
          }
        });
      } else {
        allDoctors = allSpecialties.firstWhere((e) => e.id == id).doctors ?? [];
      }

      emit(DoctorsLoaded(doctors: allDoctors));
    } catch (e) {
      emit(HomeFailure("Failed to fetch doctors: ${e.toString()}"));
    }
  }

  List<Doctor>? getDoctorsBySpecialId({required int id}) {
    return allSpecialties
        .firstWhere((specialization) => specialization.id == id,
            orElse: () => SpecialityResponse(id: id, doctors: []))
        .doctors;
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
      await getAllSpecialties();
      await getAllDoctors(); 

      emit(HomeLoadedWithSpecialties(
          doctors: allDoctors, specialties: allSpecialties));
    } catch (e) {
      emit(HomeFailure("Failed to fetch home features: ${e.toString()}"));
    }
  }
}
