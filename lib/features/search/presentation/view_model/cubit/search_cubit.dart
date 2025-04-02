import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeRepository _homeRepository;
  SearchCubit(this._homeRepository) : super(const SearchInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchEmpty(isEmpty: true));
    } else {
      // final allDoctors = await _homeRepository.getAllDoctors();
      final allDoctors = [];
      final searchedData = allDoctors
          .where((element) =>
              element..toLowerCase().contains(query.toLowerCase()))
          .toList() as List<Doctor>;
      emit(SearchedDataLoaded(searchedData: searchedData));
    }
  }

  Future<void> filter(String query) async {
    if (query.isEmpty) {
      emit(SearchEmpty(isEmpty: true));
    } else {
      // final allDoctors = await _homeRepository.getAllDoctors();
      final allDoctors = [];

      final searchedData = allDoctors
          .where(
            (element) =>
                element.specialtyName.toString().toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList() as List<Doctor>;
      emit(SearchedDataFilter(searchedDataFiltered: searchedData));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
