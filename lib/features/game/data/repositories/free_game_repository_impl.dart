import 'package:dio/dio.dart';

import '../../domain/entities/free_game_entity.dart';
import '../../domain/repositories/free_game_repository.dart';
import '../models/free_game_model.dart';

class FreeGameRepositoryImpl extends FreeGameRepository {
  FreeGameRepositoryImpl({Dio? dio}) : dio = dio ?? Dio();

  final Dio dio;

  @override
  Future<List<FreeGameEntity>> getFreeGames({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get('https://www.freetogame.com/api/games');
      final data = response.data;

      if (data is! List) {
        throw Exception('Invalid game response');
      }

      final gameList = data
          .map((item) => FreeGameModel.fromJson(item as Map<String, dynamic>))
          .map((item) => item.toEntity())
          .toList();

      final startIndex = (page - 1) * limit;

      if (startIndex >= gameList.length) {
        return [];
      }

      final endIndex = startIndex + limit;

      return gameList.sublist(
        startIndex,
        endIndex > gameList.length ? gameList.length : endIndex,
      );
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        throw Exception('No internet connection');
      }

      throw Exception(error.response?.statusMessage ?? 'Failed to load games');
    } catch (error) {
      throw Exception(error.toString().replaceFirst('Exception: ', ''));
    }
  }
}
