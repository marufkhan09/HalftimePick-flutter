class Division {
  String? name;
  int? sportId;
  int? divisionId;
  int? conferenceId;

  Division({this.name, this.sportId, this.divisionId, this.conferenceId});

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        name: json['name'] as String?,
        sportId: json['sport_id'] as int?,
        divisionId: json['division_id'] as int?,
        conferenceId: json['conference_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'sport_id': sportId,
        'division_id': divisionId,
        'conference_id': conferenceId,
      };
}
