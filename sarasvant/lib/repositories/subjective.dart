import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sarasvant/constants/dummy_data/questions/subjective.dart';
import '../models/questions/subjective.dart';
import '../constants/app_constants.dart';

class SubjectiveRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Map<String, dynamic>> createSubjective(Subjective subjective) async {
    try {
      final response = await _client.post('/subjective', data: subjective.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error creating Subjective: $e');
      return {};
    }
  }

  Future<List<Subjective>> getSubjectives(String bankId) async {
    try {
      final response = await _client.get('/subjective/bank/$bankId');
      return (response.data as List)
          .map((item) => Subjective.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching Subjectives: $e');
      return dummySubjectives;
    }
  }

  Future<Map<String, dynamic>> updateSubjective(String id, Subjective subjective) async {
    try {
      final response = await _client.put('/subjective/$id', data: subjective.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error updating Subjective: $e');
      return {};
    }
  }

  Future<bool> deleteSubjective(String id) async {
    try {
      await _client.delete('/subjective/$id');
      return true;
    } catch (e) {
      _logger.e('Error deleting Subjective: $e');
      return false;
    }
  }
}