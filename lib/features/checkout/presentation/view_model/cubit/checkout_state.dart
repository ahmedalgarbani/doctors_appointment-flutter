
import 'package:equatable/equatable.dart';

import '../../../data/models/payment_method_model.dart';


abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutSuccess extends CheckoutState {
  final List<PaymentMethodModel> payments;
  const CheckoutSuccess({required this.payments});

  @override
  List<Object> get props => [payments];
}

class CheckoutFailure extends CheckoutState {
  final String message;
  const CheckoutFailure({required this.message});

  @override
  List<Object> get props => [message];
}
