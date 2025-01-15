import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/features/auth/domain/repositories/auth_repository.dart';
import 'package:doctors_appointment/features/auth/presentation/view/widgets/signup_page_view_cubit.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPageView extends StatelessWidget {
  const SignupPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        getIt.get<AuthRepository>(),
      ),
      child: SignupPageViewCubit(),
    );
  }
}
