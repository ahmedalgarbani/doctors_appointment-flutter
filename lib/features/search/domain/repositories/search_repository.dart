import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';

abstract class SearchRepository {
  Future<List<Doctor>> searchDoctors(String query);
  Future<List<Doctor>> filterDoctors({
    List<String>? genders,
    List<String>? specialties,
    String? starts,
  });
}
