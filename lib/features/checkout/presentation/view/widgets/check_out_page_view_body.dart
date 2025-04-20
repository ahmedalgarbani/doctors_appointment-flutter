import 'package:doctors_appointment/features/appointment/presentation/viewModel/cubit/appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../home/data/models/speciality_response/doctor.dart';
import '../../../../home/data/models/speciality_response/hospital.dart';
import 'payment_method.dart';
import '../../view_model/cubit/checkout_cubit.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/style/app_color.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/features/checkout/data/models/payment_method_model.dart';
import 'package:doctors_appointment/features/checkout/presentation/view/widgets/choisen_doctor.dart';

class CheckOutPageViewBody extends StatefulWidget {
  const CheckOutPageViewBody({
    super.key,
    required this.bookingDetail,
    required this.paymentMethod,
  });

  final Map<String, dynamic> bookingDetail;
  final List<PaymentMethodModel> paymentMethod;

  @override
  State<CheckOutPageViewBody> createState() => _CheckOutPageViewBodyState();
}

class _CheckOutPageViewBodyState extends State<CheckOutPageViewBody> {
  int choice = 0;
  late String senderName;
  late String transactionNumber;
  late String doctorPrice;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    final doctor = widget.bookingDetail['doctor'] as Doctor;
    final hospital = widget.bookingDetail['hospital'] as Hospital;
    doctorPrice = (doctor.pricing ?? [])
            .firstWhere(
              (price) => price.hospital?.id == hospital.id,
              orElse: () => doctor.pricing!.first,
            )
            .amount ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          ChosenDoctor(bookeddoctor: widget.bookingDetail),
          const SizedBox(height: 20),
          PaymentMethod(
            paymentData: widget.paymentMethod,
            onChange: (value) {
              setState(() {
                choice = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildPaymentDetails(),
          const SizedBox(height: 20),
          _buildForm(),
          const Spacer(),
          CustomButton(
            onPressed: _onSubmit,
            title: "Complete",
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    final method = widget.paymentMethod[choice];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            method.description ,
            style: TextStyles.Bold16.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Account Name : ${method.accountName}",
            style: TextStyles.Bold12.copyWith(color: Colors.black),
          ),
          Text(
            "Account Number : ${method.accountNumber }",
            style: TextStyles.Bold12.copyWith(color: Colors.black),
          ),
          Text(
            "Iban Number : ${method.iban }",
            style: TextStyles.Bold12.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      autovalidateMode: _autovalidateMode,
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (value) => senderName = value!,
            validator: (value) =>
                value!.isEmpty ? "Sender Name is required" : null,
            decoration: InputDecoration(
              labelText: "Enter sender name",
              labelStyle: TextStyles.Bold12.copyWith(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: _buildOutLinedBorder(),
              focusedBorder: _buildOutLinedBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            onSaved: (value) => transactionNumber = value!,
            validator: (value) =>
                value!.isEmpty ? "Transaction Number is required" : null,
            decoration: InputDecoration(
              labelText: "Enter a Transaction Number",
              labelStyle: TextStyles.Bold12.copyWith(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: _buildOutLinedBorder(),
              focusedBorder: _buildOutLinedBorder(),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final cubit = context.read<CheckoutCubit>();
      final result = await cubit.makeappointment(data: {
        "doctor": widget.bookingDetail['doctor'].id,
        "hospital": widget.bookingDetail['hospital'].id,
        "appointment_date": widget.bookingDetail['day_id'],
        "appointment_time": widget.bookingDetail['time_id'],
        "booking_date": widget.bookingDetail['booking_date'],
        "amount": doctorPrice,
        "payment_method": widget.paymentMethod[choice].id,
        "transfer_number": transactionNumber,
        "sender_name": senderName,
        "payment_notes": "paid from mobile app",
      });

      if (!mounted) return;

      if (result) {
        context.read<AppointmentCubit>().getBookings();
        GoRouter.of(context).pushReplacement(AppRouter.KCheckOutDonePageView);
      } else {
        buildSnackbar(context, "You should login");
        // GoRouter.of(context).pushReplacement(AppRouter.KSignin);
      }

     
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  OutlineInputBorder _buildOutLinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: AppColor.primaryColor, width: 0.5),
    );
  }
}
