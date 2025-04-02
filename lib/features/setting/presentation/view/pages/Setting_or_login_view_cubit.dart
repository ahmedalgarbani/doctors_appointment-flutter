import 'package:doctors_appointment/core/helpers/build_snacbar.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/presentation/view/signin_or_login.dart';
import '../widgets/setting_view_page_body.dart';

class SettingOrLoginViewCubit extends StatelessWidget {
  const SettingOrLoginViewCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      buildWhen: (previous, current) => current is AuthCubitLoaded,
      listener: (context, state) {
        if (state is AuthCubitFailure) {
          buildSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AuthCubitLoaded) {
          return state.isAuthenticated
              ? SettingViewPageBody()
              : SigninOrLogin();
        } else if (state is AuthCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthCubitFailure) {
          return SigninOrLogin();
        }
        if (context.read<AuthCubit>().isAuth) {
          return SettingViewPageBody();
        } else {
          return SigninOrLogin();
        }
      },
    );
  }
}
