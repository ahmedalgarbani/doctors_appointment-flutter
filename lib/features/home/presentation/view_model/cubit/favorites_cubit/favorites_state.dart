part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<DoctorModel>? favoritesDoctor;

  FavoritesLoaded(this.favoritesDoctor);
}

final class FavoritesFailure extends FavoritesState {
  final String message;

  FavoritesFailure(this.message);
}
