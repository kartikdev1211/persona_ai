import 'package:dio/dio.dart';
import 'package:persona_ai/core/network/dio_client.dart';
import 'package:persona_ai/core/network/endpoints/api_endpoints.dart';
import 'package:persona_ai/models/login/request/login_request.dart';
import 'package:persona_ai/models/login/response/login_response.dart';
import 'package:persona_ai/models/signup/request/signup_request.dart';
import 'package:persona_ai/models/signup/response/signup_response.dart';
import 'package:persona_ai/models/assessment/request/assessment_request.dart';
import 'package:persona_ai/models/assessment/response/assessment_submit_response.dart';
import 'package:persona_ai/models/assessment/response/assessment_status_response.dart';
import 'package:persona_ai/models/assessment/response/assessment_response.dart';
import 'package:persona_ai/models/persona/request/persona_setup_request.dart';
import 'package:persona_ai/models/persona/response/persona_setup_response.dart';
import 'package:persona_ai/models/persona/response/persona_response.dart';
import 'package:persona_ai/models/persona/response/persona_report_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient.create({Dio? dio, String? baseUrl}) {
    return _ApiClient(dio ?? DioClient.instance.dio, baseUrl: baseUrl);
  }

  // ─── Auth ───────────────────────────────────
  @POST(ApiEndpoints.login)
  Future<LoginResponse> login(@Body() LoginRequest body);

  @POST(ApiEndpoints.signup)
  Future<SignupResponse> signup(@Body() SignupRequest body);

  // ─── Assessment ─────────────────────────────
  @POST(ApiEndpoints.submitAssessment)
  Future<AssessmentSubmitResponse> submitAssessment(
    @Body() AssessmentRequest body,
  );

  @GET(ApiEndpoints.assessmentStatus)
  Future<AssessmentStatusResponse> getAssessmentStatus();

  @GET(ApiEndpoints.assessmentMe)
  Future<AssessmentResponse> getMyAssessment();

  // ─── Persona ────────────────────────────────
  @POST(ApiEndpoints.setupPersona)
  Future<PersonaSetupResponse> setupPersona(@Body() PersonaSetupRequest body);

  @GET(ApiEndpoints.personaStatus)
  Future<PersonaSetupResponse> getPersonaStatus();

  @GET(ApiEndpoints.personaMe)
  Future<PersonaResponse> getMyPersona();

  @POST(ApiEndpoints.generateReport)
  Future<PersonaReportResponse> generateReport();

  @GET(ApiEndpoints.personaReport)
  Future<PersonaReportResponse> getPersonaReport();

  // @POST(ApiEndpoints.logout)
  // Future<void> logout();
  //
  // @POST(ApiEndpoints.refreshToken)
  // Future<Map<String, dynamic>> refreshToken(@Body() Map<String, dynamic> body);
  //
  // // ─── User / Profile ─────────────────────────
  // @GET(ApiEndpoints.profile)
  // Future<Map<String, dynamic>> getProfile();
  //
  // @PATCH(ApiEndpoints.profile)
  // Future<Map<String, dynamic>> updateProfile(@Body() Map<String, dynamic> body);
  //
  // // ─── Persona ────────────────────────────────
  // @POST(ApiEndpoints.setupPersona)
  // Future<Map<String, dynamic>> setupPersona(@Body() Map<String, dynamic> body);
  //
  // @GET(ApiEndpoints.personaReport)
  // Future<Map<String, dynamic>> getPersonaReport();
  //
  // // ─── Quiz ───────────────────────────────────
  // @GET(ApiEndpoints.quizQuestions)
  // Future<List<dynamic>> getQuizQuestions();
  //
  // @POST(ApiEndpoints.submitQuiz)
  // Future<Map<String, dynamic>> submitQuiz(@Body() Map<String, dynamic> body);
  //
  // // ─── Coach / Chat ────────────────────────────
  // @GET(ApiEndpoints.chatSessions)
  // Future<List<dynamic>> getChatSessions();
  //
  // @POST(ApiEndpoints.sendMessage)
  // Future<Map<String, dynamic>> sendMessage(@Body() Map<String, dynamic> body);
  //
  // // ─── Home ───────────────────────────────────
  // @GET(ApiEndpoints.homeFeed)
  // Future<Map<String, dynamic>> getHomeFeed();
  //
  // // ─── Missions ───────────────────────────────
  // @GET(ApiEndpoints.missions)
  // Future<List<dynamic>> getMissions();
  //
  // @POST('/missions/{id}/complete')
  // Future<Map<String, dynamic>> completeMission(@Path('id') String id);
  //
  // // ─── Progress ───────────────────────────────
  // @GET(ApiEndpoints.progress)
  // Future<Map<String, dynamic>> getProgress();
}
