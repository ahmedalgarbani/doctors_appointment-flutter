import 'package:doctors_appointment/core/db/doctor_dao.dart';
import 'package:doctors_appointment/core/dumy/dumy_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../features/auth/data/sources/auth_dao.dart';
import '../constant/constant.dart';
import 'favourites_dao.dart';
import 'specialist_dao.dart';

class DoctorAppointmentDatabase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, '${KDatabaseName}.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE patients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            birth_date TEXT NOT NULL,
            gender TEXT NOT NULL, 
            address TEXT NOT NULL,
            phone_number TEXT NOT NULL,
            email TEXT NOT NULL,
            join_date TEXT NOT NULL, 
            profile_picture TEXT, 
            notes TEXT ,
            password TEXT
          )
      ''');

      await db.execute('''
          CREATE TABLE specialties (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            image TEXT,
            show_at_home INTEGER DEFAULT 1,
            status INTEGER DEFAULT 1
          )
      ''');

      await db.execute('''
          CREATE TABLE doctors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            birthday TEXT NOT NULL,
            phone_number TEXT NOT NULL,
            specialty_id INTEGER,
            photo TEXT,
            gender INTEGER DEFAULT 1,
            email TEXT UNIQUE NOT NULL,
            experience_years INTEGER DEFAULT 0,
            sub_title TEXT,
            slug TEXT UNIQUE,
            about TEXT,
            status INTEGER DEFAULT 1,
            show_at_home INTEGER DEFAULT 1,
            FOREIGN KEY(specialty_id) REFERENCES specialties(id)
          )
      ''');
      await db.execute('''
          CREATE TABLE favourites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            patient_id INTEGER NOT NULL, 
            doctor_id INTEGER NOT NULL,
            FOREIGN KEY(patient_id) REFERENCES patients(id),
            FOREIGN KEY(doctor_id) REFERENCES doctors(id),
            UNIQUE(patient_id, doctor_id)
          )
      ''');
      await db.execute('''
          CREATE TABLE doctor_schedules (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            doctor_id INTEGER NOT NULL,
            hospital_id INTEGER,
            day INTEGER NOT NULL,
            FOREIGN KEY(doctor_id) REFERENCES doctors(id)
          )
      ''');

      await db.execute('''
          CREATE TABLE doctor_shifts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            doctor_schedule_id INTEGER NOT NULL,
            start_time TEXT NOT NULL,
            end_time TEXT NOT NULL,
            available_slots INTEGER DEFAULT 0,
            booked_slots INTEGER DEFAULT 0,
            FOREIGN KEY(doctor_schedule_id) REFERENCES doctor_schedules(id)
          )
      ''');

      await db.execute('''
          CREATE TABLE doctor_pricing (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            doctor_id INTEGER NOT NULL,
            hospital_id INTEGER,
            amount REAL NOT NULL,
            transaction_number TEXT NOT NULL UNIQUE,
            FOREIGN KEY(doctor_id) REFERENCES doctors(id)
          )
      ''');

      for (int i = 1; i <= DumyData.specialist.length - 1; i++) {
        await db.insert('specialties', {
          'name': DumyData.specialist[i].title,
          'image': DumyData.specialist[i].imagePath,
          'show_at_home': 1,
          'status': 1,
        });
      }
      for (int i = 1; i <= DumyData.doctorlist.length - 1; i++) {
        await db.insert('doctors', {
          'full_name': DumyData.doctorlist[i].name,
          'birthday': '1990-01-01',
          'phone_number': '12345678$i',
          'specialty_id': 1,
          'photo': DumyData.doctorlist[i].imagePath,
          'gender': i % 2 == 0 ? 1 : 0,
          'email': 'doctor$i@example.com',
          'experience_years': i,
          'sub_title': 'Specialist $i',
          'slug': 'doctor-$i',
          'about': 'Default doctor description',
          'status': 1,
          'show_at_home': 1,
        });
      }
    });
  }

  Future<AuthDao> authDao() async {
    final db = await initializedDB();
    return AuthDao(db);
  }

  Future<DoctorDao> doctorDao() async {
    final db = await initializedDB();
    return DoctorDao(db);
  }

  Future<SpecialistDao> specialistDao() async {
    final db = await initializedDB();
    return SpecialistDao(db);
  }

  Future<FavouritesDao> favouritesDao() async {
    final db = await initializedDB();
    return FavouritesDao(db);
  }
}
