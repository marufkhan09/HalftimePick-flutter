class Division {
  int? divisionId;
  int? conferenceId;
  int? sportId;
  String? name;

  Division({this.divisionId, this.conferenceId, this.sportId, this.name});

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        divisionId: json['division_id'] as int?,
        conferenceId: json['conference_id'] as int?,
        sportId: json['sport_id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'division_id': divisionId,
        'conference_id': conferenceId,
        'sport_id': sportId,
        'name': name,
      };
}
