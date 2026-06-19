import '../entities/free_game_entity.dart';
import '../repositories/free_game_repository.dart';

class GetFreeGamesUseCase {
  const GetFreeGamesUseCase(this.freeGameRepository);

  final FreeGameRepository freeGameRepository;

  Future<List<FreeGameEntity>> call({required int page, required int limit}) {
    return freeGameRepository.getFreeGames(page: page, limit: limit);
  }
}
