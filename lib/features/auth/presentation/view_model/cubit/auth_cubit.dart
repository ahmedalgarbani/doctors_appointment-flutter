import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:equatable/equatable.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:doctors_appointment/features/auth/domain/repositories/auth_repository.dart';
import '../../../../../core/constant/constant.dart';
import '../../../data/model/signin_user_request.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthCubitLoading());

  bool isAuth = false;

  Future<void> createUserWithEmailAndPassword(
      {required Patient patient}) async {
    emit(SignupCubitLoading());

    var result =
        await _authRepository.createUserWithEmailAndPassword(patient: patient);
    result.fold(
      (l) {
        isAuth = false;
        emit(SignupCubitFailure("Failed to create user: ${l.errorMessage}"));
      },
      (r) {
        emit(
            SignupCubitLoaded(successMessage: "User registered successfully."));
      },
    );
  }

  Future<void> signinUserWithEmailAndPassword(
      {required SigninUserRequest signinUserRequest}) async {
    emit(LoginCubitLoading());
    final result = await _authRepository.signinUserWithEmailAndPassword(
      signinUserRequest: signinUserRequest,
    );

    result.fold(
      (failure) {
        emit(LoginCubitFailure("Failed to sign in: ${failure.errorMessage}"));
      },
      (loggedInPatient) async {
        isAuth = true;
        await _authRepository.setAuthUserId(loggedInPatient.id!);
        await loadAuthUserId();
        emit(LoginCubitLoaded(
          patient: loggedInPatient,
          authUserId: loggedInPatient.id,
          successMessage: "The sign-in was successful",
          isAuthenticated: true,
        ));
      },
    );
  }

  Future<void> loadAuthUserId() async {
    emit(AuthCubitLoading());

    final int? userId = await _authRepository.getAuthUserId();
    log(userId.toString());
    if (userId != null && userId > 0) {
      isAuth = true;
      Pref.setInt(KauthUserId, userId);
      emit(AuthCubitLoaded(authUserId: userId, isAuthenticated: isAuth));
    } else {
      isAuth = false;
      emit(AuthCubitLoaded(authUserId: null, isAuthenticated: isAuth));
    }
  }

  Future<void> logout() async {
    log("hello");
    emit(AuthCubitLoading());
    bool isLoggedOut = await _authRepository.logout();
    if (isLoggedOut) {
      isAuth = false;
      emit(AuthCubitLoaded(isAuthenticated: isAuth, authUserId: null));
    } else {
      emit(AuthCubitFailure("Failed to logout, please try again."));
    }
  }

  Future<Map<String, dynamic>?> getAuthUserData() async {
    try {
      return await _authRepository.getAuthUserData();
    } catch (e) {
      return null;
    }
  }
}
