part of 'auth_cubit.dart';

sealed class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object?> get props => [];
}

final class AuthCubitInitial extends AuthCubitState {}

final class AuthCubitLoading extends AuthCubitState {}

final class AuthCubitLoaded extends AuthCubitState {
  final Patient? patient;
  final String? successMessage;
  final int? authUserId;
  final bool? isAuthenticated;
  const AuthCubitLoaded({
    this.successMessage,
    this.patient,
    this.authUserId,
    this.isAuthenticated,
  });

  @override
  List<Object?> get props => [patient, successMessage];
}

final class AuthCubitFailure extends AuthCubitState {
  final String message;
  const AuthCubitFailure(this.message);

  @override
  List<Object?> get props => [message];
}
