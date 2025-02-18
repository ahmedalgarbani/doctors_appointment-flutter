import 'package:doctors_appointment/core/helpers/shared_prefrace.dart';
import 'package:doctors_appointment/core/router/router.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/core/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constant/constant.dart';
import 'core/custom_bloc_ovserver.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/presentation/view_model/cubit/favorites_cubit/favorites_cubit.dart';
import 'features/home/presentation/view_model/cubit/home_cubit.dart';
import 'features/setting/presentation/view/pages/Setting_or_login_view_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Pref.init();
  setup();
  int authPatientId = await Pref.getInt(KauthUserId);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<HomeRepository>(),
          )..getHomeFeatures(),
        ),
        BlocProvider(
          child: SettingOrLoginViewCubit(),
          create: (context) => AuthCubit(
            getIt.get<AuthRepository>(),
          )..loadAuthUserId(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(getIt.get<HomeRepository>())
            ..getAllFavorites(authPatientId),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
