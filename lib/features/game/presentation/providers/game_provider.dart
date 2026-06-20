import '../../data/repositories/free_game_repository_impl.dart';
import '../../domain/entities/free_game_entity.dart';
import '../../domain/usecases/get_free_games_usecase.dart';

class GameProvider {
  GameProvider({FreeGameRepositoryImpl? freeGameRepository}) {
    this.freeGameRepository = freeGameRepository ?? FreeGameRepositoryImpl();
    getFreeGamesUseCase = GetFreeGamesUseCase(this.freeGameRepository);
  }

  late final FreeGameRepositoryImpl freeGameRepository;
  late final GetFreeGamesUseCase getFreeGamesUseCase;

  Future<List<FreeGameEntity>> getFreeGames({
    required int page,
    required int limit,
  }) {
    return getFreeGamesUseCase.call(page: page, limit: limit);
  }
}
