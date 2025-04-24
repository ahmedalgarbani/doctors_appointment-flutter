import 'dart:developer';

import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/core/services/api_service.dart';
import 'package:doctors_appointment/core/services/get_it.dart';
import 'package:doctors_appointment/features/home/data/models/speciality_response/doctor.dart';

import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final _dio = getIt.get<ApiService>();
  @override
  Future<List<Doctor>> filterDoctors({
    List<String>? genders,
    List<String>? specialties,
    String? starts,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
// {
//     "genders": ["Male", "Female"],
//     "specialties": ["Dentist", "Cardiologist"],
//     "stars": 4
//   }
      if (genders != null && genders.isNotEmpty) {
        queryParams['gender'] = genders.join(',');
      }

      if (specialties != null && specialties.isNotEmpty) {
        queryParams['specialties__name'] = specialties.join(',');
      }
      if (starts != null && starts.isNotEmpty) {
        queryParams['starts'] = starts;
      }
      final response = await _dio.post(
        EndPoints.doctor_filter,
        data: queryParams,
      );
      log("ahmed --- ${response.data}");
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }

      final List data = response.data ?? [];
      return data.map((e) => Doctor.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Doctor>> searchDoctors(String query) async {
    try {
      final response = await _dio.get(
        EndPoints.doctor_search,
        params: {
          'search': query,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }
      final List data = response.data['results'] ?? [];
      return data.map((e) => Doctor.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
