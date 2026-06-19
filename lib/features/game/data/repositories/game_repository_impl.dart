import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../domain/entities/game_details_entity.dart';
import '../../domain/repositories/game_repository.dart';
import '../models/game_details_response_model.dart';

class GameRepositoryImpl extends GameRepository {
  GameRepositoryImpl({ApiClient? apiClient})
    : apiClient = apiClient ?? ApiClient();

  final ApiClient apiClient;

  @override
  Future<GameDetailsEntity> getGameDetails() async {
    try {
      final response = await apiClient.dio.get(
        '/eventsnextleague.php',
        queryParameters: {'id': '4328'},
      );

      final responseModel = GameDetailsResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      final eventList = responseModel.events ?? [];

      if (eventList.isEmpty) {
        throw Exception('No game data available');
      }

      return eventList.first.toEntity();
    } on DioException catch (error) {
      throw Exception(
        error.response?.statusMessage ?? 'Failed to load game details',
      );
    } catch (error) {
      throw Exception(error.toString().replaceFirst('Exception: ', ''));
    }
  }
}
