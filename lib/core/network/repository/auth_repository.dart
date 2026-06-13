import 'package:persona_ai/core/network/api_client.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/storage/storage_helper.dart';
import 'package:persona_ai/models/login/request/login_request.dart';
import 'package:persona_ai/models/login/response/login_response.dart';
import 'package:persona_ai/models/signup/request/signup_request.dart';
import 'package:persona_ai/models/signup/response/signup_response.dart';
import 'package:persona_ai/screens/auth/bloc/event/auth_event.dart';

class AuthRepository {
  final ApiClient _client;
  AuthRepository({ApiClient? client}) : _client = client ?? ApiClient.create();
  Future<ApiResult<SignupResponse>> signup({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final result = await safeApiCall(
      () => _client.signup(
        SignupRequest(
          fullName: fullName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      ),
    );
    if (result case ApiSuccess(:final data)) {
      await StorageHelper.saveAuthToken(data.accessToken);
      StorageHelper.isLoggedIn = true;
      StorageHelper.userName = data.fullName;
    }
    return result;
  }

  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final result = await safeApiCall(
      () => _client.login(LoginRequest(email: email, password: password)),
    );
    if (result case ApiSuccess(:final data)) {
      await StorageHelper.saveAuthToken(data.accessToken);
      StorageHelper.isLoggedIn = true;
    }
    return result;
  }

  Future<void> logout() async {
    await StorageHelper.clearUserSession();
  }
}
