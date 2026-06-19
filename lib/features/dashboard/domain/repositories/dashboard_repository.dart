import '../entities/sports_event_entity.dart';

abstract class DashboardRepository {
  const DashboardRepository();

  Future<List<SportsEventEntity>> getUpcomingMatches();
}
