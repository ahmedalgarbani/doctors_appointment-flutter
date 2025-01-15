import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/features/home/presentation/view/widgets/home_widgets/home_page_view_body.dart';
import 'package:doctors_appointment/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/home_state.dart';

class HomePageViewCubit extends StatelessWidget {
  const HomePageViewCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          buildSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeLoadedWithSpecialties ) {
          return HomePageViewBody(allDoctors: state.doctors);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
