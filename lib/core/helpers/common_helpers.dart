import 'dart:convert';

import 'package:dio/dio.dart';

abstract class CommonHelpers {
  static dynamic decodeJson(Response<dynamic> response) {
    var responseJson = jsonDecode(response.data);
    return responseJson;
  }
}
