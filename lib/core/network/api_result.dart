import 'package:persona_ai/core/network/app_exception.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

final class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

final class ApiFailure<T> extends ApiResult<T> {
  final AppException exception;
  const ApiFailure(this.exception);
}

// ─── Safe call wrapper ────────────────────────
// Use in repositories to avoid try/catch boilerplate everywhere.
//
// Example:
//   final result = await safeApiCall(() => _client.getProfile());
//   switch (result) {
//     case ApiSuccess(:final data) => ...
//     case ApiFailure(:final exception) => ...
//   }
Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    final data = await call();
    return ApiSuccess(data);
  } on AppException catch (e) {
    return ApiFailure(e);
  } catch (e) {
    return ApiFailure(
      AppException(message: e.toString(), type: AppErrorType.unknown),
    );
  }
}
