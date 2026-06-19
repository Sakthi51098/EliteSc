import '../../data/repositories/free_game_repository_impl.dart';
import '../../data/repositories/game_repository_impl.dart';
import '../../domain/entities/free_game_entity.dart';
import '../../domain/entities/game_details_entity.dart';
import '../../domain/usecases/get_free_games_usecase.dart';
import '../../domain/usecases/get_game_details_usecase.dart';

class GameProvider {
  GameProvider({
    GameRepositoryImpl? gameRepository,
    FreeGameRepositoryImpl? freeGameRepository,
  }) {
    this.gameRepository = gameRepository ?? GameRepositoryImpl();
    this.freeGameRepository = freeGameRepository ?? FreeGameRepositoryImpl();
    getGameDetailsUseCase = GetGameDetailsUseCase(this.gameRepository);
    getFreeGamesUseCase = GetFreeGamesUseCase(this.freeGameRepository);
  }

  late final GameRepositoryImpl gameRepository;
  late final FreeGameRepositoryImpl freeGameRepository;
  late final GetGameDetailsUseCase getGameDetailsUseCase;
  late final GetFreeGamesUseCase getFreeGamesUseCase;

  Future<GameDetailsEntity> getGameDetails() {
    return getGameDetailsUseCase.call();
  }

  Future<List<FreeGameEntity>> getFreeGames({
    required int page,
    required int limit,
  }) {
    return getFreeGamesUseCase.call(page: page, limit: limit);
  }
}
