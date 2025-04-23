import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/widgets/custom_progress_hud.dart';
import 'package:doctors_appointment/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/build_snacbar.dart';
import '../../../../home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'signin_page_view_body.dart';

class SigninPageViewCubit extends StatefulWidget {
  const SigninPageViewCubit({super.key});

  @override
  State<SigninPageViewCubit> createState() => _SigninPageViewCubitState();
}

class _SigninPageViewCubitState extends State<SigninPageViewCubit> {

  initState() {
    super.initState();
      context.read<FavoritesCubit>().getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      buildWhen: (previous, current) {
        return current is LoginCubitLoaded ||
            current is LoginCubitFailure ||
            current is LoginCubitLoading;
      },
      listenWhen: (previous, current) {
        return current is LoginCubitLoaded ||
            current is LoginCubitFailure ||
            current is LoginCubitLoading;
      },
      listener: (context, state) {
        if (state is LoginCubitLoaded) {
          buildSnackbar(
              context, state.successMessage ?? "the Signin was successfuly",
              color: Colors.green);
        
          
          GoRouter.of(context).pushReplacement(AppRouter.KHomePage);
        } else if (state is LoginCubitFailure) {
          buildSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is LoginCubitLoading ? true : false,
          child: SigninPageViewBody(),
        );
      },
    );
  }
}
