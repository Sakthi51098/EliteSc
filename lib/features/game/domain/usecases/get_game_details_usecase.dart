import '../entities/game_details_entity.dart';
import '../repositories/game_repository.dart';

class GetGameDetailsUseCase {
  const GetGameDetailsUseCase(this.gameRepository);

  final GameRepository gameRepository;

  Future<GameDetailsEntity> call() {
    return gameRepository.getGameDetails();
  }
}
