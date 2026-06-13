import 'package:persona_ai/core/network/api_client.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/models/profile/request/delete_account_request.dart';
import 'package:persona_ai/models/profile/request/update_notification_request.dart';
import 'package:persona_ai/models/profile/response/profile_response.dart';

class ProfileRepository {
  final ApiClient _client;
  ProfileRepository({ApiClient? client})
    : _client = client ?? ApiClient.create();

  Future<ApiResult<ProfileResponse>> getProfile() {
    return safeApiCall(() => _client.getProfile());
  }

  Future<ApiResult<void>> updateNotifications({required bool enabled}) {
    return safeApiCall(
      () => _client.updateNotifications(
        UpdateNotificationRequest(notificationsEnabled: enabled),
      ),
    );
  }

  Future<ApiResult<void>> deleteAccount({required String password}) {
    return safeApiCall(
      () => _client.deleteAccount(DeleteAccountRequest(password: password)),
    );
  }
}
