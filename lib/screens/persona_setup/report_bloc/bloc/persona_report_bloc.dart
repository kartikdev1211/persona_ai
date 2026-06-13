import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/persona_repository.dart';
import 'package:persona_ai/screens/persona_setup/report_bloc/event/persona_report_event.dart';
import 'package:persona_ai/screens/persona_setup/report_bloc/state/persona_report_state.dart';

class PersonaReportBloc extends Bloc<PersonaReportEvent, PersonaReportState> {
  final PersonaRepository _personaRepository;

  PersonaReportBloc({required PersonaRepository personaRepository})
    : _personaRepository = personaRepository,
      super(const PersonaReportInitial()) {
    on<GenerateReport>(_onGenerateReport);
    on<FetchReport>(_onFetchReport);
  }

  Future<void> _onGenerateReport(
    GenerateReport event,
    Emitter<PersonaReportState> emit,
  ) async {
    emit(const PersonaReportLoading());
    final result = await _personaRepository.generateReport();
    switch (result) {
      case ApiSuccess(:final data):
        emit(PersonaReportLoaded(data));
      case ApiFailure(:final exception):
        emit(PersonaReportError(exception.message));
    }
  }

  Future<void> _onFetchReport(
    FetchReport event,
    Emitter<PersonaReportState> emit,
  ) async {
    emit(const PersonaReportLoading());
    final result = await _personaRepository.getPersonaReport();
    switch (result) {
      case ApiSuccess(:final data):
        emit(PersonaReportLoaded(data));
      case ApiFailure(:final exception):
        emit(PersonaReportError(exception.message));
    }
  }
}
