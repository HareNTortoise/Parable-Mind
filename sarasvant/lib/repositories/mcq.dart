import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sarasvant/constants/dummy_data/questions/mcq.dart';
import '../constants/app_constants.dart';
import '../models/questions/mcq.dart';

class MCQRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Map<String, dynamic>> createMCQ(MCQ mcq) async {
    try {
      final response = await _client.post('/mcq', data: mcq.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error creating MCQ: $e');
      dummyMCQs.add(mcq);
      return mcq.toJson();
    }
  }

  Future<List<MCQ>> getMCQs(String bankId) async {
    try {
      final response = await _client.get('/mcq/bank/$bankId');
      return (response.data as List)
          .map((item) => MCQ.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching MCQs: $e');
      return dummyMCQs.where((mcq) => mcq.bankId == bankId).toList();
    }
  }

  Future<Map<String, dynamic>> updateMCQ(String id, MCQ mcq) async {
    try {
      final response = await _client.put('/mcq/$id', data: mcq.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error updating MCQ: $e');
      final index = dummyMCQs.indexWhere((item) => item.id == id);
      if (index != -1) {
        dummyMCQs[index] = mcq;
      }
      return mcq.toJson();
    }
  }

  Future<bool> deleteMCQ(String id) async {
    try {
      await _client.delete('/mcq/$id');
      return true;
    } catch (e) {
      _logger.e('Error deleting MCQ: $e');
      dummyMCQs.removeWhere((mcq) => mcq.id == id);
      return true;
    }
  }
}