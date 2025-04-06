import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sarasvant/constants/dummy_data/questions/msq.dart';
import '../constants/app_constants.dart';
import '../models/questions/msq.dart';

class MSQRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Map<String, dynamic>> createMSQ(MSQ msq) async {
    try {
      final response = await _client.post('/msq', data: msq.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error creating MSQ: $e');
      dummyMSQs.add(msq);
      return msq.toJson();
    }
  }

  Future<List<MSQ>> getMSQs(String bankId) async {
    try {
      final response = await _client.get('/msq/bank/$bankId');
      return (response.data as List)
          .map((item) => MSQ.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching MSQs: $e');
      return dummyMSQs.where((msq) => msq.bankId == bankId).toList();
    }
  }

  Future<Map<String, dynamic>> updateMSQ(String id, MSQ msq) async {
    try {
      final response = await _client.put('/msq/$id', data: msq.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error updating MSQ: $e');
      final index = dummyMSQs.indexWhere((item) => item.id == id);
      if (index != -1) {
        dummyMSQs[index] = msq;
      }
      return msq.toJson();
    }
  }

  Future<bool> deleteMSQ(String id) async {
    try {
      await _client.delete('/msq/$id');
      return true;
    } catch (e) {
      _logger.e('Error deleting MSQ: $e');
      dummyMSQs.removeWhere((msq) => msq.id == id);
      return true;
    }
  }
}