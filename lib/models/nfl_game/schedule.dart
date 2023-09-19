class Schedule {
  String? leagueName;
  bool? conferenceCompetition;
  String? seasonType;
  int? seasonYear;
  int? week;
  String? weekName;
  String? weekDetail;
  String? eventName;
  String? attendance;

  Schedule({
    this.leagueName,
    this.conferenceCompetition,
    this.seasonType,
    this.seasonYear,
    this.week,
    this.weekName,
    this.weekDetail,
    this.eventName,
    this.attendance,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        leagueName: json['league_name'] as String?,
        conferenceCompetition: json['conference_competition'] as bool?,
        seasonType: json['season_type'] as String?,
        seasonYear: json['season_year'] as int?,
        week: json['week'] as int?,
        weekName: json['week_name'] as String?,
        weekDetail: json['week_detail'] as String?,
        eventName: json['event_name'] as String?,
        attendance: json['attendance'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'league_name': leagueName,
        'conference_competition': conferenceCompetition,
        'season_type': seasonType,
        'season_year': seasonYear,
        'week': week,
        'week_name': weekName,
        'week_detail': weekDetail,
        'event_name': eventName,
        'attendance': attendance,
      };
}
