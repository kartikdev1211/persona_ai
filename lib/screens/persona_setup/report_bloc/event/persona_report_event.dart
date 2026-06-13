sealed class PersonaReportEvent {
  const PersonaReportEvent();
}

class GenerateReport extends PersonaReportEvent {
  const GenerateReport();
}

class FetchReport extends PersonaReportEvent {
  const FetchReport();
}
