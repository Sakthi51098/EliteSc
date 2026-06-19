import '../entities/game_details_entity.dart';

abstract class GameRepository {
  const GameRepository();

  Future<GameDetailsEntity> getGameDetails();
}
