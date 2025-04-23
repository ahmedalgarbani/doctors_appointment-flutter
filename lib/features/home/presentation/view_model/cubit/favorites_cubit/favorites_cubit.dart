import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/speciality_response/doctor.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final HomeRepository _homeRepository;

  FavoritesCubit(this._homeRepository) : super(FavoritesInitial());
  List<Doctor>? favorites;
  bool isFav = false;
  
  Future<void> getAllFavorites({bool isLogout = false}) async {
    emit(FavoritesLoading());
    try {
      if (isLogout) {
        favorites = [];

        emit(FavoritesLoaded(favorites));

      } else {
        favorites = await _homeRepository.getAllFavourites();
        if (favorites != null) {
          emit(FavoritesLoaded(favorites));
        }
      }
    } catch (e) {
      emit(FavoritesFailure("Failed to fetch favorites: ${e.toString()}"));
    }
  }

  Future<bool> addNewFavorite({
    required int doctorId,
  }) async {
    emit(FavoritesLoading());
    var result = await _homeRepository.addNewFavorite(
      doctorId: doctorId,
    );

    return result.fold(
      (failure) {
        return false;
      },
      (r) async {
        try {
          await getAllFavorites();
          return true;
        } catch (e) {
          return false;
        }
      },
    );
  }

  Future<void> removeFavorite({
    required num doctorId,
  }) async {
    try {
      final result = await _homeRepository.deleteFavorite(
        doctorId: doctorId!.toInt(),
      );
      if (result) {
        await getAllFavorites();
      }
    } catch (e) {
      emit(FavoritesFailure("${e.toString()}"));
    }
  }

  Future<bool> isFavorite({required int doctorId}) async {
    final authuserId = await Pref.getInt(KauthUserId);
    emit(FavoritesLoading());
    if (favorites == null) return false;
    try {
      bool result = false;
      if (favorites!.isNotEmpty) {
        result = favorites!.any((element) => element.id == doctorId);
      }
      if (result) emit(FavoritesLoaded(favorites));
      isFav = result;
      return result;
    } catch (e) {
      isFav = false;
      emit(FavoritesFailure("Failed to check favorite: ${e.toString()}"));
      return false;
    }
  }
}
