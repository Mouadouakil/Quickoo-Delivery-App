import 'package:dio/dio.dart';

Dio dio() {
  var dio = Dio(); // with default Options

// Set default configs
  dio.options.baseUrl = 'http://10.0.2.2:8000/api';
  dio.options.headers['accept'] = 'Apllication/Json';
  return dio;
}
