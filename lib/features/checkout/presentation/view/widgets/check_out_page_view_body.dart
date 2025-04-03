import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/style/app_color.dart';
import 'package:doctors_appointment/core/style/text_style.dart';
import 'package:doctors_appointment/core/widgets/custom_button.dart';
import 'package:doctors_appointment/features/checkout/data/models/payment_method_model.dart';
import 'package:doctors_appointment/features/checkout/presentation/view/widgets/choisen_doctor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'payment_method.dart';

class CheckOutPageViewBody extends StatefulWidget {
  const CheckOutPageViewBody(
      {super.key, required this.bookingDetail, required this.paymentMethod});
  final Map<String, dynamic> bookingDetail;
  final List<PaymentMethodModel> paymentMethod;

  @override
  State<CheckOutPageViewBody> createState() => _CheckOutPageViewBodyState();
}

class _CheckOutPageViewBodyState extends State<CheckOutPageViewBody> {
  int choice = 0;
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.paymentMethod[choice].description}",
                  style: TextStyles.Bold16.copyWith(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Account Name : ${widget.paymentMethod[choice].accountName}" ??
                      'N/A',
                  style: TextStyles.Bold12.copyWith(color: Colors.black),
                ),
                Text(
                  "Account Number : ${widget.paymentMethod[choice].accountNumber}" ??
                      'N/A',
                  style: TextStyles.Bold12.copyWith(color: Colors.black),
                ),
                Text(
                  "Iban Number : ${widget.paymentMethod[choice].iban}" ?? 'N/A',
                  style: TextStyles.Bold12.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Enter sender name",
              labelStyle: TextStyles.Bold12.copyWith(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: _buildOutLinedBorder(),
              focusedBorder: _buildOutLinedBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Enter a Transaction Number",
              labelStyle: TextStyles.Bold12.copyWith(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: _buildOutLinedBorder(),
              focusedBorder: _buildOutLinedBorder(),
            ),
          ),
          const Spacer(),
          CustomButton(
            onPressed: () {
              GoRouter.of(context)
                  .pushReplacement(AppRouter.KCheckOutDonePageView);
            },
            title: "Complete",
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildOutLinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: AppColor.primaryColor, width: 0.5),
    );
  }
}
