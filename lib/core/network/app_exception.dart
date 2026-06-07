import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;
  final AppErrorType type;

  AppException({
    required this.message,
    this.statusCode,
    this.type = AppErrorType.unknown,
  });
  factory AppException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppException(
          message: 'Request timed out. Check your connection.',
          type: AppErrorType.timeout,
        );

      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final serverMsg = _extractServerMessage(e.response);
        return AppException(
          statusCode: code,
          message: serverMsg ?? _statusMessage(code),
          type: _typeFromStatus(code),
        );

      case DioExceptionType.cancel:
        return AppException(
          message: 'Request cancelled.',
          type: AppErrorType.cancelled,
        );

      case DioExceptionType.connectionError:
        return AppException(
          message: 'No internet connection.',
          type: AppErrorType.noInternet,
        );

      default:
        return AppException(
          message: e.message ?? 'Unexpected error.',
          type: AppErrorType.unknown,
        );
    }
  }
  static String? _extractServerMessage(Response? response) {
    try {
      final data = response?.data;
      if (data is Map) {
        return (data['message'] ?? data['error'] ?? data['detail']?.toString());
      }
    } catch (_) {}
    return null;
  }

  static String _statusMessage(int? code) => switch (code) {
    400 => 'Bad request.',
    401 => 'Unauthorized. Please log in again.',
    403 => 'Forbidden.',
    404 => 'Resource not found.',
    422 => 'Validation error.',
    429 => 'Too many requests. Slow down.',
    500 => 'Server error. Try again later.',
    503 => 'Service unavailable.',
    _ => 'Unexpected error (${code ?? "??"}).',
  };
  static AppErrorType _typeFromStatus(int? code) => switch (code) {
    401 => AppErrorType.unauthorized,
    403 => AppErrorType.forbidden,
    404 => AppErrorType.notFound,
    422 => AppErrorType.validation,
    429 => AppErrorType.rateLimited,
    _ => AppErrorType.server,
  };
  @override
  String toString() => "AppException[$type]: $message";
}

enum AppErrorType {
  timeout,
  noInternet,
  unauthorized,
  forbidden,
  notFound,
  validation,
  rateLimited,
  server,
  cancelled,
  unknown,
}
