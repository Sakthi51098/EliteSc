import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/sports_event_entity.dart';
import '../../domain/usecases/get_games_usecase.dart';

class DashboardProvider {
  DashboardProvider({DashboardRepositoryImpl? dashboardRepository})
    : this.withRepository(dashboardRepository ?? DashboardRepositoryImpl());

  DashboardProvider.withRepository(this.dashboardRepository)
    : getGamesUseCase = GetGamesUseCase(dashboardRepository);

  final DashboardRepositoryImpl dashboardRepository;
  final GetGamesUseCase getGamesUseCase;

  Future<List<SportsEventEntity>> getUpcomingMatches() {
    return getGamesUseCase.call();
  }
}
