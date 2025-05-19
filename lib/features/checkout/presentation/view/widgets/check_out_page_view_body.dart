import 'dart:io';

import 'package:doctors_appointment/features/checkout/data/models/booking_payment_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/save_image_to_system_file.dart';
import '../../../../../core/widgets/image_picker_input.dart';
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

// ... (بقية الاستيرادات كما هي)

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
  late File _pickImage;

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
      child: SingleChildScrollView(
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
            const SizedBox(height: 30),
            CustomButton(
              height: 50,
              onPressed: _onSubmit,
              title: "إكمال",
            ),
          ],
        ),
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
            method.description,
            style: TextStyles.Bold16.copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "اسم الحساب : ${method.accountName}", 
            style: TextStyles.Bold12.copyWith(color: Colors.black),
          ),
          Text(
            "رقم الحساب : ${method.accountNumber}",
            style: TextStyles.Bold12.copyWith(color: Colors.black),
          ),
          Text(
            "رقم الآيبان : ${method.iban}", 
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
      child: _buildImagePicker(),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final cubit = context.read<CheckoutCubit>();
      final imagePath = await saveImageToSystemFile(imageFile: _pickImage);

      final result = await cubit.makeappointment(
        bookingtemp: BookingPaymentTemp(
            doctor: widget.bookingDetail['doctor'].id,
            hospital: widget.bookingDetail['hospital'].id,
            appointmentDate: widget.bookingDetail['day_id'],
            appointmentTime: widget.bookingDetail['time_id'],
            amount: doctorPrice,
            booking_date: widget.bookingDetail['booking_date'],
            paymentMethod: widget.paymentMethod[choice].id,
            paymentNotes: "تم الدفع من خلال تطبيق الجوال",
            paymentReceiptPath: imagePath),
      );

      if (!mounted) return;

      if (result) {
        GoRouter.of(context).pushReplacement(AppRouter.KCheckOutDonePageView);
      } else {
        buildSnackbar(context, "يجب عليك تسجيل الدخول");
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  Widget _buildImagePicker() {
    return ImagePickerInputField(
      onImageSelected: (image) => _pickImage = image!,
    );
  }

  OutlineInputBorder _buildOutLinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: AppColor.primaryColor, width: 0.5),
    );
  }
}
