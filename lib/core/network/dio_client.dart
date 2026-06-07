import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:persona_ai/core/network/app_interceptor.dart';
import 'package:persona_ai/core/network/endpoints/api_endpoints.dart';

class DioClient {
  DioClient._();
  static DioClient? _instance;
  static DioClient get instance => _instance ??= DioClient._();
  late final Dio dio = _buildDio();

  Dio _buildDio() {
    final d = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
    d.interceptors.addAll([
      AppInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    ]);
    return d;
  }
}
