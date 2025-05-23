import 'package:equatable/equatable.dart';
import '../../../../home/data/models/speciality_response/doctor.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchedDataLoaded extends SearchState {
  final List<Doctor> searchedData;

  const SearchedDataLoaded({required this.searchedData});

  @override
  List<Object?> get props => [searchedData];
}

class SearchedDataFilter extends SearchState {
  final List<Doctor> searchedDataFiltered;

  const SearchedDataFilter({required this.searchedDataFiltered});

  @override
  List<Object?> get props => [searchedDataFiltered];
}

class SearchEmpty extends SearchState {
  final bool isEmpty;

  const SearchEmpty({required this.isEmpty});

  @override
  List<Object?> get props => [isEmpty];
}
