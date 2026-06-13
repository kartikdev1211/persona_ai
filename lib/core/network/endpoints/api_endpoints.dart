class ApiEndpoints {
  // static const String baseUrl = "http://127.0.0.1:8000";
  // static const String baseUrl = "http://10.0.2.2:8000";
  static const String baseUrl = "https://persona-ai-backend-j5zn.onrender.com";

  // Auth
  static const String login = "/auth/login";
  static const String signup = "/auth/signup";
  static const String logout = "/auth/logout";
  // static const String refreshToken = "/auth/refresh";

  // Assessment
  static const String submitAssessment = "/assessment/submit";
  static const String assessmentStatus = "/assessment/status";
  static const String assessmentMe = "/assessment/me";
  //
  // Profile
  static const String getProfile = "/profile/me";
  static const String updateNotifications = "/profile/notifications";
  static const String deleteAccount = "/profile/delete-account";
  //
  // Persona
  static const String setupPersona = "/persona/setup";
  static const String personaStatus = "/persona/status";
  static const String personaMe = "/persona/me";
  static const String personaReport = "/persona/report";
  static const String generateReport = "/persona/report/generate";
  //
  // // Quiz
  // static const String quizQuestions = "/quiz/questions";
  // static const String submitQuiz = "/quiz/submit";
  //
  // // Coach
  // static const String chatSessions = "/coach/sessions";
  // static const String sendMessage = "/coach/message";
  //
  // // Home
  // static const String homeFeed = "/home/feed";
  //
  // // Missions
  // static const String missions = "/missions";
  // static const String completeMission = "/missions/{id}/complete";
  //
  // // Progress
  // static const String progress = "/progress";
}
