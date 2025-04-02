import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:doctors_appointment/features/auth/data/model/create_user_request.dart';
import 'package:doctors_appointment/features/auth/domain/repositories/auth_repository.dart';
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
    try {
      final int? userId = await _authRepository.getAuthUserId();
      emit(AuthCubitLoaded(authUserId: userId, isAuthenticated: isAuth));
    } catch (e) {
      emit(AuthCubitFailure("Failed to load user ID: ${e.toString()}"));
    }
  }

  Future<void> logout() async {
    emit(AuthCubitLoading());
    bool isLoggedOut = await _authRepository.logout();
    if (isLoggedOut) {
      isAuth = false;
      emit(AuthCubitLoaded(isAuthenticated: isAuth, authUserId: null));
    } else {
      emit(AuthCubitFailure("Failed to logout, please try again."));
    }
  }
}
