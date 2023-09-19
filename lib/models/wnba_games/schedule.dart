class Schedule {
  String? leagueName;
  bool? conferenceCompetition;
  String? seasonType;
  int? seasonYear;
  String? eventName;
  String? attendance;

  Schedule({
    this.leagueName,
    this.conferenceCompetition,
    this.seasonType,
    this.seasonYear,
    this.eventName,
    this.attendance,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        leagueName: json['league_name'] as String?,
        conferenceCompetition: json['conference_competition'] as bool?,
        seasonType: json['season_type'] as String?,
        seasonYear: json['season_year'] as int?,
        eventName: json['event_name'] as String?,
        attendance: json['attendance'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'league_name': leagueName,
        'conference_competition': conferenceCompetition,
        'season_type': seasonType,
        'season_year': seasonYear,
        'event_name': eventName,
        'attendance': attendance,
      };
}
