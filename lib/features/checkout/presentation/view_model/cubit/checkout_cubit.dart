import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../data/models/booking_payment_temp.dart';
import '../../../data/repositories/payment_repository.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PaymentRepository paymentRepository;

  CheckoutCubit({required this.paymentRepository}) : super(CheckoutLoading());

  Future<void> fetchPaymentMethods({int? hospital}) async {
    emit(CheckoutLoading());
    try {
      final result =
          await paymentRepository.getPaymentMethods(hospital: hospital);
      result.fold(
        (failure) => emit(CheckoutFailure(message: failure.errorMessage)),
        (payments) => emit(CheckoutSuccess(payments: payments)),
      );
    } catch (e) {
      emit(CheckoutFailure(message: "cannot fetch payments method"));
    }
  }
  Future<void> makePayment() async {
    emit(CheckoutLoading());
    try {
      final result = await paymentRepository.makePayment();
      result.fold(
        (failure) => emit(CheckoutFailure(message: failure.errorMessage)),
        (payments) => emit(CheckoutSuccess(payments: payments)),
      );
    } catch (e) {
      emit(CheckoutFailure(message: "cannot fetch payments method"));
    }
  }
Future<bool> makeappointment({BookingPaymentTemp? bookingtemp}) async {
  log(bookingtemp.toString());
  try {
    final result = await paymentRepository.makeappointment(bookingtemp: bookingtemp);

    return result.fold(
      (failure) {
log(failure.errorMessage);
        return false;
      },
      (_) {
        return true;
      },
    );
  } catch (e) {
    return false;
  }
}

  
}
