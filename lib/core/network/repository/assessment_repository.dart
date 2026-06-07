import 'package:persona_ai/core/network/api_client.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/models/assessment/request/assessment_request.dart';
import 'package:persona_ai/models/assessment/response/assessment_response.dart';
import 'package:persona_ai/models/assessment/response/assessment_status_response.dart';
import 'package:persona_ai/models/assessment/response/assessment_submit_response.dart';

class AssessmentRepository {
  final ApiClient _client;
  AssessmentRepository({ApiClient? client})
    : _client = client ?? ApiClient.create();

  Future<ApiResult<AssessmentSubmitResponse>> submitAssessment({
    required String socialSituation,
    required String currentGoal,
    required String selfImprovementConsistency,
    required String biggestObstacle,
  }) {
    return safeApiCall(
      () => _client.submitAssessment(
        AssessmentRequest(
          socialSituation: socialSituation,
          currentGoal: currentGoal,
          selfImprovementConsistency: selfImprovementConsistency,
          biggestObstacle: biggestObstacle,
        ),
      ),
    );
  }

  Future<ApiResult<AssessmentStatusResponse>> getAssessmentStatus() {
    return safeApiCall(() => _client.getAssessmentStatus());
  }

  Future<ApiResult<AssessmentResponse>> getMyAssessment() {
    return safeApiCall(() => _client.getMyAssessment());
  }
}
