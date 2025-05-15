import 'package:dio/dio.dart';

class ServerFailureTest implements Exception {
  final String message;

  ServerFailureTest(this.message);
factory ServerFailureTest.fromDiorError(dynamic error) {
    try {
      if (error.response?.data is Map<String, dynamic>) {
        final data = error.response!.data;

        if (data.containsKey('detail')) {
          return ServerFailureTest(data['detail']);
        }

        if (data.isNotEmpty) {
          final errors = data.entries.map((entry) {
            final value = entry.value;
            if (value is List && value.isNotEmpty) {
              return "${entry.key}: ${value.first}";
            } else {
              return "${entry.key}: $value";
            }
          }).join("\n");

          return ServerFailureTest(errors);
        }
      }

      return ServerFailureTest("حدث خطأ غير متوقع. الرجاء المحاولة لاحقاً.");
    } catch (e) {
      return ServerFailureTest("فشل في الاتصال بالخادم.");
    }
  }


  @override
  String toString() => message;
}
