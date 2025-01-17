import 'package:doctors_appointment/core/db/sqflite_db.dart';
import 'package:doctors_appointment/core/services/sqflite_data_base.dart';
import 'package:doctors_appointment/features/auth/data/repos/auth_repository_impl.dart';
import 'package:doctors_appointment/features/auth/data/sources/auth_service.dart';
import 'package:doctors_appointment/features/auth/domain/repositories/auth_repository.dart';
import 'package:doctors_appointment/features/home/data/repositories/home_repository_impl.dart';
import 'package:doctors_appointment/features/home/domain/repositories/home_repository.dart';
import 'package:get_it/get_it.dart';

import 'database_service.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<DoctorAppointmentDatabase>(
      DoctorAppointmentDatabase());

  getIt.registerSingleton<AuthService>(
    SqfliteAuthServiceImple(getIt.get<DoctorAppointmentDatabase>()),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt.get<AuthService>()),
  );

//home

 getIt.registerSingleton<DatabaseService>(
    SqfliteDataBase(getIt.get<DoctorAppointmentDatabase>()),
  );


  getIt.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(getIt.get<DatabaseService>()),
  );

// Search

 

}
