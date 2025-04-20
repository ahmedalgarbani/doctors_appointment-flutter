import 'package:dio/dio.dart';
import 'package:doctors_appointment/core/db/sqflite_db.dart';
import 'package:doctors_appointment/core/services/api_auth_service.dart';
import 'package:doctors_appointment/core/services/api_service.dart';
import 'package:doctors_appointment/features/appointment/data/repositories/appointment_repo_impl.dart';
import 'package:doctors_appointment/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:doctors_appointment/features/auth/data/repos/auth_repository_impl.dart';
import 'package:doctors_appointment/features/auth/data/sources/auth_service.dart';
import 'package:doctors_appointment/features/auth/domain/repositories/auth_repository.dart';
import 'package:doctors_appointment/features/checkout/data/repositories/payment_repository.dart';
import 'package:doctors_appointment/features/checkout/domain/repositories/payment_repository_implement.dart';
import 'package:doctors_appointment/features/home/data/repositories/home_repository_impl.dart';
import 'package:doctors_appointment/features/home/data/sources/home_services_api.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentation/view_model/cubit/auth_cubit.dart';
import '../network/app_interceptors.dart';
import 'database_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<AppIntercepters>(
    AppIntercepters(client: getIt<Dio>()),
  );

  // Database-related dependencies
  getIt.registerSingleton<DoctorAppointmentDatabase>(
      DoctorAppointmentDatabase());

  // API-related dependencies
  getIt.registerSingleton<ApiService>(ApiService());

  getIt.registerSingleton<AuthService>(
    ApiAuthService(),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt.get<AuthService>()),
  );

  getIt.registerSingleton<PaymentRepository>(
    PaymentRepositoryImpl(),
  );

  getIt.registerSingleton<AppointmentRepo>(
    AppointmentRepoImpl(),
  );
  getIt.registerSingleton<DatabaseService>(
    HomeServicesApi(),
  );

  // Home repository
  getIt.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(getIt.get<DatabaseService>()),
  );



}


// ahmed888@gmail.com