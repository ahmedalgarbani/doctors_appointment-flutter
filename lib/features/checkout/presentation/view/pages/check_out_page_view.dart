import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:doctors_appointment/features/checkout/presentation/view_model/cubit/checkout_state.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/payment_repository.dart';
import '../widgets/check_out_page_view_body.dart';

class CheckOutPageView extends StatelessWidget {
  const CheckOutPageView({super.key, required this.bookingDetail});
  final Map<String, dynamic> bookingDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Payment",
          style: TextStyles.Bold16.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: KVerticalPadding, horizontal: KHorizantalPadding),
          child: BlocProvider(
              create: (context) => CheckoutCubit(
                  paymentRepository: getIt.get<PaymentRepository>()),
              child: CheckoutPageViewBodyBlocBuilder(
                bookingDetail: bookingDetail,
              )),
        ),
      ),
    );
  }
}

class CheckoutPageViewBodyBlocBuilder extends StatefulWidget {
  const CheckoutPageViewBodyBlocBuilder(
      {super.key, required this.bookingDetail});
  final Map<String, dynamic> bookingDetail;

  @override
  State<CheckoutPageViewBodyBlocBuilder> createState() => _CheckoutPageViewBodyBlocBuilderState();
}

class _CheckoutPageViewBodyBlocBuilderState extends State<CheckoutPageViewBodyBlocBuilder> {
  initState() {
    super.initState();
    context.read<CheckoutCubit>().fetchPaymentMethods(hospital: widget.bookingDetail['hospital'].id);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
 if (state is CheckoutFailure) {
          
          buildSnackbar(context, state.message);
        }
      },
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            context
                .read<CheckoutCubit>()
                .fetchPaymentMethods(hospital: widget.bookingDetail['hospital'].id);
            return Center(child: CircularProgressIndicator());
          } else if (state is CheckoutSuccess) {
            return CheckOutPageViewBody(
              bookingDetail: widget.bookingDetail,
              paymentMethod: state.payments!,
            );
          } else if (state is CheckoutFailure) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
