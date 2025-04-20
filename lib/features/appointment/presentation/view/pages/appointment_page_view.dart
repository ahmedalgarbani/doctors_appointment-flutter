import 'package:doctors_appointment/core/constant/constant.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:doctors_appointment/features/appointment/presentation/viewModel/cubit/appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment_cubit_builder.dart';

class AppointmentPageView extends StatelessWidget {
  const AppointmentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: KHorizantalPadding, right: KHorizantalPadding),
          child: AppointmentCubitBuilder(),
        ),
      ),
    );
  }
}

