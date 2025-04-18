import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:sarasvant/repositories/ai/mcq_variation_generator.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/questions/mcq.dart';

part 'mcq_variation_event.dart';
part 'mcq_variation_state.dart';

class MCQVariationBloc extends Bloc<MCQVariationEvent, MCQVariationState> {
  final VariationRepository mcqVariationRepository;

  MCQVariationBloc(this.mcqVariationRepository) : super(MCQVariationInitial()) {
    on<GenerateMCQVariations>(_onGenerateMCQVariations);
  }

  Future<void> _onGenerateMCQVariations(
    GenerateMCQVariations event,
    Emitter<MCQVariationState> emit,
  ) async {
    emit(MCQVariationLoading());
    try {
      final Response response = await mcqVariationRepository.generateMCQVariations(event.mcq);

      List<MCQ> variations = [];

      for (var item in response.data['variations']) {
        variations.add(MCQ.fromJson({
          ...item as Map<String, dynamic>,
          "id": Uuid().v4(),
          "bankId": event.mcq.bankId,
          "variableIds": [],
          "points": event.mcq.points,
        }));
      }

      if (response.statusCode! >= 400) {
        throw StateError(
          response.data['error'] ?? 'An error occurred while logging in.',
        );
      }

      emit(MCQVariationSuccess(variations));
    } on DioException catch (e) {
      emit(MCQVariationFailure('Network error: ${e.message}'));
    } on StateError catch (e) {
      emit(MCQVariationFailure(e.message));
    } catch (e) {
      Logger().e('Error generating MCQ variations: $e');
      emit(MCQVariationFailure(e.toString()));
    }
  }
}
