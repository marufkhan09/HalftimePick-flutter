class Conference {
  int? conferenceId;
  int? sportId;
  String? name;

  Conference({this.conferenceId, this.sportId, this.name});

  factory Conference.fromJson(Map<String, dynamic> json) => Conference(
        conferenceId: json['conference_id'] as int?,
        sportId: json['sport_id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'conference_id': conferenceId,
        'sport_id': sportId,
        'name': name,
      };
}
