class Score {
  String? eventId;
  String? broadcast;
  int? gameClock;
  int? scoreAway;
  int? scoreHome;
  String? updatedAt;
  String? venueName;
  int? gamePeriod;
  int? winnerAway;
  int? winnerHome;
  String? eventStatus;
  String? displayClock;
  String? venueLocation;
  String? eventStatusDetail;
  List<dynamic>? scoreAwayByPeriod;
  List<dynamic>? scoreHomeByPeriod;

  Score({
    this.eventId,
    this.broadcast,
    this.gameClock,
    this.scoreAway,
    this.scoreHome,
    this.updatedAt,
    this.venueName,
    this.gamePeriod,
    this.winnerAway,
    this.winnerHome,
    this.eventStatus,
    this.displayClock,
    this.venueLocation,
    this.eventStatusDetail,
    this.scoreAwayByPeriod,
    this.scoreHomeByPeriod,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        eventId: json['event_id'] ?? "",
        broadcast: json['broadcast'] ?? "",
        gameClock: json['game_clock'] as int?,
        scoreAway: json['score_away'] as int?,
        scoreHome: json['score_home'] as int?,
        updatedAt: json['updated_at'] ?? "",
        venueName: json['venue_name'] ?? "",
        gamePeriod: json['game_period'] as int?,
        winnerAway: json['winner_away'] as int?,
        winnerHome: json['winner_home'] as int?,
        eventStatus: json['event_status'] ?? "",
        displayClock: json['display_clock'] ?? "",
        venueLocation: json['venue_location'] ?? "",
        eventStatusDetail: json['event_status_detail'] ?? "",
        scoreAwayByPeriod: json['score_away_by_period'] as List<dynamic>?,
        scoreHomeByPeriod: json['score_home_by_period'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'event_id': eventId,
        'broadcast': broadcast,
        'game_clock': gameClock,
        'score_away': scoreAway,
        'score_home': scoreHome,
        'updated_at': updatedAt,
        'venue_name': venueName,
        'game_period': gamePeriod,
        'winner_away': winnerAway,
        'winner_home': winnerHome,
        'event_status': eventStatus,
        'display_clock': displayClock,
        'venue_location': venueLocation,
        'event_status_detail': eventStatusDetail,
        'score_away_by_period': scoreAwayByPeriod,
        'score_home_by_period': scoreHomeByPeriod,
      };
}
