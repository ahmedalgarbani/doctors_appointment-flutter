import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:doctors_appointment/features/auth/domain/repositories/auth_repository.dart';
import '../../../data/model/signin_user_request.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthCubitLoading());

  Future<void> createUserWithEmailAndPassword(
      {required Patient patient}) async {
    emit(AuthCubitLoading());
    try {
      await _authRepository.createUserWithEmailAndPassword(patient: patient);
      emit(AuthCubitLoaded(
        successMessage: "User registered successfully.",
      ));
    } catch (e) {
      emit(AuthCubitFailure("Failed to create user: ${e.toString()}"));
    }
  }

  Future<void> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) async {
    emit(AuthCubitLoading());
    final result = await _authRepository.signinUserWithEmailAndPassword(
        signinUserRequest: signinUserRequest);

    result.fold(
      (failure) {
        emit(AuthCubitFailure("Failed to sign in: ${failure.errorMessage}"));
      },
      (loginedPatient) async {
        await _authRepository.setAuthUserId(loginedPatient.id!);
        emit(
          AuthCubitLoaded(
            patient: loginedPatient,
            authUserId: loginedPatient.id,
            successMessage: "The sign-in was successful",
            isAuthenticated: true,
          ),
        );
      },
    );
  }

  Future<void> loadAuthUserId() async {
    emit(AuthCubitLoading());
    try {
      final int? userId = await _authRepository.getAuthUserId();
      if (userId != 0) {
        emit(AuthCubitLoaded(authUserId: userId, isAuthenticated: true));
      } else {
        emit(AuthCubitLoaded(isAuthenticated: false));
      }
    } catch (e) {
      emit(AuthCubitFailure("Failed to load user ID: ${e.toString()}"));
    }
  }

  Future<void> logout() async {
    emit(AuthCubitLoading());
    var isLogout = await _authRepository.logout();
    if (isLogout) {
      emit(AuthCubitFailure("Failed to logout try again"));
    } else {
      emit(AuthCubitLoaded(isAuthenticated: !isLogout));
    }
  }
}
