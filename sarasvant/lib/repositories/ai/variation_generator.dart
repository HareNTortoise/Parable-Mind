import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../constants/app_constants.dart';
import '../../models/questions/mcq.dart';

class VariationRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.microserviceDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Response> generateMCQVariations(MCQ mcq) async {
    try {
      final response = await _client.post(
        '/generate-mcq-variations',
        data: {
          'question': mcq.question,
          'options': mcq.options,
          'answerIndex': mcq.answerIndex,
        },
      );

      return response;
    } catch (e) {
      _logger.e('Error generating MCQ variations: $e');
      throw Exception('Failed to generate MCQ variations');
    }
  }
}
