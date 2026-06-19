import '../entities/free_game_entity.dart';

abstract class FreeGameRepository {
  const FreeGameRepository();

  Future<List<FreeGameEntity>> getFreeGames({
    required int page,
    required int limit,
  });
}
