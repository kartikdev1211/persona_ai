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
  }) {
    return safeApiCall(
      () => _client.signup(
        SignupRequest(
          fullName: fullName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      ),
    );
  }

  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final result = await safeApiCall(
      () => _client.login(LoginRequest(email: email, password: password)),
    );
    if (result case ApiSuccess(:final data)) {
      StorageHelper.authToken = data.accessToken;
      StorageHelper.isLoggedIn = true;
    }
    return result;
  }

  void logout() {
    StorageHelper.clearUserSession();
  }
}
