import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sarasvant/constants/dummy_data/questions/nat.dart';
import '../constants/app_constants.dart';
import '../models/questions/nat.dart';

class NATRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Map<String, dynamic>> createNAT(NAT nat) async {
    try {
      final response = await _client.post('/nat', data: nat.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error creating NAT: $e');
      return {};
    }
  }

  Future<List<NAT>> getNATs(String bankId) async {
    try {
      final response = await _client.get('/nat/bank/$bankId');
      return (response.data as List)
          .map((item) => NAT.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching NATs: $e');
      return dummyNATs;
    }
  }

  Future<Map<String, dynamic>> updateNAT(String id, NAT nat) async {
    try {
      final response = await _client.put('/nat/$id', data: nat.toJson());
      return response.data;
    } catch (e) {
      _logger.e('Error updating NAT: $e');
      return {};
    }
  }

  Future<bool> deleteNAT(String id) async {
    try {
      await _client.delete('/nat/$id');
      return true;
    } catch (e) {
      _logger.e('Error deleting NAT: $e');
      return false;
    }
  }
}