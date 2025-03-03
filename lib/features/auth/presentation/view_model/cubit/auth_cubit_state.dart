part of 'auth_cubit.dart';

sealed class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object?> get props => [];
}

final class AuthCubitInitial extends AuthCubitState {}

final class AuthCubitLoading extends AuthCubitState {}

final class AuthCubitLoaded extends AuthCubitState {
  final int? authUserId;
  final bool isAuthenticated;

  const AuthCubitLoaded({this.authUserId, required this.isAuthenticated});

  @override
  List<Object?> get props => [authUserId, isAuthenticated];
}

final class AuthCubitFailure extends AuthCubitState {
  final String message;
  const AuthCubitFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Login states
final class LoginCubitLoading extends AuthCubitState {}

final class LoginCubitLoaded extends AuthCubitState {
  final Patient? patient;
  final String? successMessage;
  final int? authUserId;
  final bool isAuthenticated;

  const LoginCubitLoaded({
    this.patient,
    this.authUserId,
    this.successMessage,
    required this.isAuthenticated,
  });

  @override
  List<Object?> get props => [patient, successMessage, authUserId, isAuthenticated];
}

final class LoginCubitFailure extends AuthCubitState {
  final String message;
  const LoginCubitFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Signup states
final class SignupCubitLoading extends AuthCubitState {}

final class SignupCubitLoaded extends AuthCubitState {
  final String successMessage;

  const SignupCubitLoaded({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

final class SignupCubitFailure extends AuthCubitState {
  final String message;
  const SignupCubitFailure(this.message);

  @override
  List<Object?> get props => [message];
}
