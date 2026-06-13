import 'package:persona_ai/models/persona/response/persona_report_response.dart';

sealed class PersonaReportState {
  const PersonaReportState();
}

class PersonaReportInitial extends PersonaReportState {
  const PersonaReportInitial();
}

class PersonaReportLoading extends PersonaReportState {
  const PersonaReportLoading();
}

class PersonaReportLoaded extends PersonaReportState {
  final PersonaReportResponse report;
  const PersonaReportLoaded(this.report);
}

class PersonaReportError extends PersonaReportState {
  final String message;
  const PersonaReportError(this.message);
}
