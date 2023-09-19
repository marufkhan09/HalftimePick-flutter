class Sport {
  int? sportId;
  String? sportName;

  Sport({this.sportId, this.sportName});

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        sportId: json['sport_id'] as int?,
        sportName: json['sport_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'sport_id': sportId,
        'sport_name': sportName,
      };
}
