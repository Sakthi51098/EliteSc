class GameDetailsEntity {
  const GameDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.eventDate,
    required this.eventTime,
    required this.venue,
    this.homeScore,
    this.awayScore,
  });

  final String id;
  final String title;
  final String description;
  final String league;
  final String homeTeam;
  final String awayTeam;
  final String eventDate;
  final String eventTime;
  final String venue;
  final int? homeScore;
  final int? awayScore;
}
