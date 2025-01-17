import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/doctor_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final HomeRepository _homeRepository;

  FavoritesCubit(this._homeRepository) : super(FavoritesInitial());
  List<DoctorModel>? favorites;
  bool isFav = false;
  Future<void> getAllFavorites(int patientId) async {
    emit(FavoritesLoading());
    try {
      favorites = await _homeRepository.getAllFavourites(patientId);
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
          await getAllFavorites(patientId);
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }

  Future<void> removeFavorite({
    required int doctorId,
    required int patientId,
  }) async {
    try {
      final result = await _homeRepository.deleteFavorite(
        doctorId: doctorId,
        patientId: patientId,
      );
      if (result) {
        await getAllFavorites(patientId);
      }
    } catch (e) {
      emit(FavoritesFailure("${e.toString()}"));
    }
  }

  Future<bool> isFavorite({required int doctorId}) async {
    final authuserId = await Pref.getInt(KauthUserId);
    emit(FavoritesLoading());
    try {
      final result = await _homeRepository.isFavorite(
          doctorId: doctorId, patientId: authuserId);
      if (result) emit(FavoritesLoaded(favorites));
      isFav = true;
      return true;
    } catch (e) {
      isFav = false;
      return false;
    }
  }
}
