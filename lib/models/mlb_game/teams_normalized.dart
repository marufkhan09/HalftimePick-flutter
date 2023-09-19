import 'conference.dart';
import 'division.dart';

class TeamsNormalized {
  String? name;
  String? mascot;
  String? record;
  bool? isAway;
  bool? isHome;
  int? ranking;
  int? teamId;
  Division? division;
  Conference? conference;
  int? divisionId;
  String? abbreviation;
  int? conferenceId;

  TeamsNormalized({
    this.name,
    this.mascot,
    this.record,
    this.isAway,
    this.isHome,
    this.ranking,
    this.teamId,
    this.division,
    this.conference,
    this.divisionId,
    this.abbreviation,
    this.conferenceId,
  });

  factory TeamsNormalized.fromJson(Map<String, dynamic> json) {
    return TeamsNormalized(
      name: json['name'] as String?,
      mascot: json['mascot'] as String?,
      record: json['record'] as String?,
      isAway: json['is_away'] as bool?,
      isHome: json['is_home'] as bool?,
      ranking: json['ranking'] as int?,
      teamId: json['team_id'] as int?,
      division: json['division'] == null
          ? null
          : Division.fromJson(json['division'] as Map<String, dynamic>),
      conference: json['conference'] == null
          ? null
          : Conference.fromJson(json['conference'] as Map<String, dynamic>),
      divisionId: json['division_id'] as int?,
      abbreviation: json['abbreviation'] as String?,
      conferenceId: json['conference_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'mascot': mascot,
        'record': record,
        'is_away': isAway,
        'is_home': isHome,
        'ranking': ranking,
        'team_id': teamId,
        'division': division?.toJson(),
        'conference': conference?.toJson(),
        'division_id': divisionId,
        'abbreviation': abbreviation,
        'conference_id': conferenceId,
      };
}
