class Conference {
  int? conferenceId;
  int? divisionId;
  int? sportId;
  String? name;

  Conference({this.conferenceId, this.divisionId, this.sportId, this.name});

  factory Conference.fromJson(Map<String, dynamic> json) => Conference(
        conferenceId: json['conference_id'] as int?,
        divisionId: json['division_id'] as int?,
        sportId: json['sport_id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'conference_id': conferenceId,
        'division_id': divisionId,
        'sport_id': sportId,
        'name': name,
      };
}
