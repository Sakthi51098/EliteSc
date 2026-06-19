class SportsEventEntity {
  const SportsEventEntity({
    required this.id,
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.eventDate,
    required this.eventTime,
    required this.venue,
    this.homeScore,
    this.awayScore,
    this.thumbnail,
  });

  final String id;
  final String league;
  final String homeTeam;
  final String awayTeam;
  final String eventDate;
  final String eventTime;
  final String venue;
  final int? homeScore;
  final int? awayScore;
  final String? thumbnail;
}
