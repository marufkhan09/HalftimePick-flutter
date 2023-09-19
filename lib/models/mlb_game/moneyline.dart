class Moneyline {
  String? format;
  int? lineId;
  String? eventId;
  int? sportId;
  int? affiliateId;
  DateTime? dateUpdated;
  double? moneylineAway;
  double? moneylineDraw;
  double? moneylineHome;
  double? moneylineAwayDelta;
  double? moneylineDrawDelta;
  double? moneylineHomeDelta;

  Moneyline({
    this.format,
    this.lineId,
    this.eventId,
    this.sportId,
    this.affiliateId,
    this.dateUpdated,
    this.moneylineAway,
    this.moneylineDraw,
    this.moneylineHome,
    this.moneylineAwayDelta,
    this.moneylineDrawDelta,
    this.moneylineHomeDelta,
  });

  factory Moneyline.fromJson(Map<String, dynamic> json) => Moneyline(
        format: json['format'] ?? "",
        lineId: json['line_id'] ?? 0,
        eventId: json['event_id'] as String?,
        sportId: json['sport_id'] ?? 0,
        affiliateId: json['affiliate_id'] ?? 0,
        dateUpdated: json['date_updated'] == null
            ? null
            : DateTime.parse(json['date_updated'] as String),
        moneylineAway: (json['moneyline_away'] as num?)?.toDouble(),
        moneylineDraw: (json['moneyline_draw'] as num?)?.toDouble(),
        moneylineHome: (json['moneyline_home'] as num?)?.toDouble(),
        moneylineAwayDelta: (json['moneyline_away_delta'] as num?)?.toDouble(),
        moneylineDrawDelta: json['moneyline_draw_delta'] != null
            ? double.parse(json['moneyline_draw_delta'].toString())
            : 0.0,
        moneylineHomeDelta: (json['moneyline_home_delta'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'format': format,
        'line_id': lineId,
        'event_id': eventId,
        'sport_id': sportId,
        'affiliate_id': affiliateId,
        'date_updated': dateUpdated?.toIso8601String(),
        'moneyline_away': moneylineAway,
        'moneyline_draw': moneylineDraw,
        'moneyline_home': moneylineHome,
        'moneyline_away_delta': moneylineAwayDelta,
        'moneyline_draw_delta': moneylineDrawDelta,
        'moneyline_home_delta': moneylineHomeDelta,
      };
}
