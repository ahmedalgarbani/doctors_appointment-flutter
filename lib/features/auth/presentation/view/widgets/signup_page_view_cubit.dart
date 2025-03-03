import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/features/auth/presentation/view/signup_page_view_body.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/build_snacbar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';

class SignupPageViewCubit extends StatelessWidget {
  const SignupPageViewCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      buildWhen: (previous, current) {
        return current is SignupCubitLoaded || current is SignupCubitFailure || current is SignupCubitLoading;
      },
      listenWhen: (previous, current) {
        return current is SignupCubitLoaded || current is SignupCubitFailure || current is SignupCubitLoading;
      },
      listener: (context, state) {
        if (state is SignupCubitLoaded) {
          GoRouter.of(context).push(AppRouter.KSignin);
        } else if (state is SignupCubitFailure) {
          buildSnackbar(context, state.message);
        }
      },
      
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignupCubitLoading ? true : false,
          child: SignUpPageViewBody(),
        );
      },
    );
  }
}
