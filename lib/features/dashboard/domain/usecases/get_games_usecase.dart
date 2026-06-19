import '../entities/sports_event_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetGamesUseCase {
  const GetGamesUseCase(this.dashboardRepository);

  final DashboardRepository dashboardRepository;

  Future<List<SportsEventEntity>> call() {
    return dashboardRepository.getUpcomingMatches();
  }
}
