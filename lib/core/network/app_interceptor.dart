import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:persona_ai/core/network/app_exception.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await StorageHelper.getAuthToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('-> ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('<- ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appExp = AppException.fromDioException(err);
    debugPrint('X ${err.requestOptions.path}-> ${appExp.message}');
    handler.next(err.copyWith(error: appExp));
  }
}
