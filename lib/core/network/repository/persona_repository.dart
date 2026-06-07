import 'package:persona_ai/core/network/api_client.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/models/persona/request/persona_setup_request.dart';
import 'package:persona_ai/models/persona/response/persona_response.dart';
import 'package:persona_ai/models/persona/response/persona_setup_response.dart';

class PersonaRepository {
  final ApiClient _client;
  PersonaRepository({ApiClient? client})
    : _client = client ?? ApiClient.create();

  Future<ApiResult<PersonaSetupResponse>> setupPersona({
    required String personaName,
    required int avatarIndex,
    required String confidenceLevel,
    required String focusGoal,
  }) {
    return safeApiCall(
      () => _client.setupPersona(
        PersonaSetupRequest(
          personaName: personaName,
          avatarIndex: avatarIndex,
          confidenceLevel: confidenceLevel,
          focusGoal: focusGoal,
        ),
      ),
    );
  }

  Future<ApiResult<PersonaSetupResponse>> getPersonaStatus() {
    return safeApiCall(() => _client.getPersonaStatus());
  }

  Future<ApiResult<PersonaResponse>> getMyPersona() {
    return safeApiCall(() => _client.getMyPersona());
  }
}
