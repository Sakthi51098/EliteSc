import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entities/sports_event_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/sports_event_response_model.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl({ApiClient? apiClient})
    : apiClient = apiClient ?? ApiClient();

  final ApiClient apiClient;

  @override
  Future<List<SportsEventEntity>> getUpcomingMatches() async {
    try {
      final response = await apiClient.dio.get(
        '/eventsnextleague.php',
        queryParameters: {'id': '4328'},
      );

      final responseModel = SportsEventResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      final eventList = responseModel.events ?? [];

      return eventList.map((item) => item.toEntity()).toList();
    } on DioException catch (error) {
      throw Exception(
        error.response?.statusMessage ?? 'Failed to load upcoming matches',
      );
    } catch (_) {
      throw Exception('Unable to parse sports data');
    }
  }
}
