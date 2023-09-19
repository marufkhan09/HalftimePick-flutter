class Conference {
  String? name;
  int? sportId;
  int? conferenceId;

  Conference({this.name, this.sportId, this.conferenceId});

  factory Conference.fromJson(Map<String, dynamic> json) => Conference(
        name: json['name'] as String?,
        sportId: json['sport_id'] as int?,
        conferenceId: json['conference_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'sport_id': sportId,
        'conference_id': conferenceId,
      };
}
