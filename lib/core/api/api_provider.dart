import 'package:ceiba_technical_test/core/env.dart';
import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiProvider {
  late Dio dio;
  ApiProvider() {
    dio = Dio(BaseOptions(baseUrl: Env.api));
    dio.interceptors.add(ApiInterceptors());
  }
}
