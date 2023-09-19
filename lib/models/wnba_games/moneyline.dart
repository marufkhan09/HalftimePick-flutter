class Moneyline {
  double? moneylineAway;
  double? moneylineAwayDelta;
  double? moneylineHome;
  double? moneylineHomeDelta;
  double? moneylineDraw;
  double? moneylineDrawDelta;
  int? lineId;
  String? eventId;
  int? sportId;
  int? affiliateId;
  DateTime? dateUpdated;
  String? format;

  Moneyline({
    this.moneylineAway,
    this.moneylineAwayDelta,
    this.moneylineHome,
    this.moneylineHomeDelta,
    this.moneylineDraw,
    this.moneylineDrawDelta,
    this.lineId,
    this.eventId,
    this.sportId,
    this.affiliateId,
    this.dateUpdated,
    this.format,
  });

  factory Moneyline.fromJson(Map<String, dynamic> json) => Moneyline(
        moneylineAway: (json['moneyline_away'] as num?)?.toDouble(),
        moneylineAwayDelta: (json['moneyline_away_delta'] as num?)?.toDouble(),
        moneylineHome: (json['moneyline_home'] as num?)?.toDouble(),
        moneylineHomeDelta: (json['moneyline_home_delta'] as num?)?.toDouble(),
        moneylineDraw: (json['moneyline_draw'] as num?)?.toDouble(),
        moneylineDrawDelta: (json['moneyline_draw_delta'] as num?)?.toDouble(),
        lineId: json['line_id'] as int?,
        eventId: json['event_id'] as String?,
        sportId: json['sport_id'] as int?,
        affiliateId: json['affiliate_id'] as int?,
        dateUpdated: json['date_updated'] == null
            ? null
            : DateTime.parse(json['date_updated'] as String),
        format: json['format'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'moneyline_away': moneylineAway,
        'moneyline_away_delta': moneylineAwayDelta,
        'moneyline_home': moneylineHome,
        'moneyline_home_delta': moneylineHomeDelta,
        'moneyline_draw': moneylineDraw,
        'moneyline_draw_delta': moneylineDrawDelta,
        'line_id': lineId,
        'event_id': eventId,
        'sport_id': sportId,
        'affiliate_id': affiliateId,
        'date_updated': dateUpdated?.toIso8601String(),
        'format': format,
      };
}
