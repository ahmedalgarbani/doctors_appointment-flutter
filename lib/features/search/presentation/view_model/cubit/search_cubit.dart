import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';

import '../../../domain/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(const SearchEmpty(isEmpty: true));
      return;
    }
    try {
      final List<Doctor> results = await _searchRepository.searchDoctors(query);
      emit(SearchedDataLoaded(searchedData: results));
    } catch (e) {
      log(e.toString());
      emit(const SearchEmpty(isEmpty: true));
    }
  }

  Future<void> filter({
    List<String>? genders,
    List<String>? specialties,
    int? stars,
  }) async {
    if ((genders == null || genders.isEmpty) &&
        (specialties == null || specialties.isEmpty) &&
        stars == null) {
      emit(const SearchEmpty(isEmpty: true));
      return;
    }

    try {
      final List<Doctor> results = await _searchRepository.filterDoctors(
        genders: genders,
        specialties: specialties,
        starts: stars?.toString(),
      );
      emit(SearchedDataFilter(searchedDataFiltered: results));
    } catch (_) {
      emit(const SearchEmpty(isEmpty: true));
    }
  }

  void clearSearch() {
    emit(const SearchInitial());
  }
}
