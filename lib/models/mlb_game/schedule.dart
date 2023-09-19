class Schedule {
  String? attendance;
  String? eventName;
  String? leagueName;
  String? seasonType;
  int? seasonYear;
  bool? conferenceCompetition;

  Schedule({
    this.attendance,
    this.eventName,
    this.leagueName,
    this.seasonType,
    this.seasonYear,
    this.conferenceCompetition,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        attendance: json['attendance'] as String?,
        eventName: json['event_name'] as String?,
        leagueName: json['league_name'] as String?,
        seasonType: json['season_type'] as String?,
        seasonYear: json['season_year'] as int?,
        conferenceCompetition: json['conference_competition'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'attendance': attendance,
        'event_name': eventName,
        'league_name': leagueName,
        'season_type': seasonType,
        'season_year': seasonYear,
        'conference_competition': conferenceCompetition,
      };
}
