import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeRepository _homeRepository;
  SearchCubit(this._homeRepository) : super(const SearchInitial());

  Future<void> search(String query)async {
    if (query.isEmpty) {
      emit(SearchEmpty(isEmpty: true));
    } else {
      final allDoctors = await _homeRepository.getAllDoctors();
      final searchedData = allDoctors
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(SearchedDataLoaded(searchedData: searchedData));
    }
  }

  Future<void> filter(String query) async{
    if (query.isEmpty) {
      emit(SearchEmpty(isEmpty: true));
    } else {
            final allDoctors = await _homeRepository.getAllDoctors();

      final searchedData = allDoctors
          .where(
            (element) =>
                element.specialtyName.toString().toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
      emit(SearchedDataFilter(searchedDataFiltered: searchedData));
    }
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
