import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctors_appointment/core/error/failure.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/doctor_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final HomeRepository _homeRepository;

  FavoritesCubit(this._homeRepository) : super(FavoritesInitial());
  List<DoctorModel>? favorites;
  Future<void> getAllFavorites(int patientId) async {
    emit(FavoritesLoading());
    try {
      final favorites = await _homeRepository.getAllFavourites(patientId);
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesFailure("Failed to fetch favorites: ${e.toString()}"));
    }
  }

  Future<bool> addNewFavorite({
    required int doctorId,
    required int patientId,
  }) async {
    emit(FavoritesLoading());
    var result = await _homeRepository.addNewFavorite(
      doctorId: doctorId,
      patientId: patientId,
    );

    return result.fold(
      (failure) {
        return false;
      },
      (_) async {
        try {
          final favorites = await _homeRepository.getAllFavourites(patientId);
          emit(FavoritesLoaded(favorites));
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }
}
