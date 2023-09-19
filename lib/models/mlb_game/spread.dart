class Spread {
  String? format;
  int? lineId;
  String? eventId;
  int? sportId;
  int? affiliateId;
  DateTime? dateUpdated;
  double? pointSpreadAway;
  double? pointSpreadHome;
  double? pointSpreadAwayDelta;
  double? pointSpreadAwayMoney;
  double? pointSpreadHomeDelta;
  double? pointSpreadHomeMoney;
  double? pointSpreadAwayMoneyDelta;
  double? pointSpreadHomeMoneyDelta;

  Spread({
    this.format,
    this.lineId,
    this.eventId,
    this.sportId,
    this.affiliateId,
    this.dateUpdated,
    this.pointSpreadAway,
    this.pointSpreadHome,
    this.pointSpreadAwayDelta,
    this.pointSpreadAwayMoney,
    this.pointSpreadHomeDelta,
    this.pointSpreadHomeMoney,
    this.pointSpreadAwayMoneyDelta,
    this.pointSpreadHomeMoneyDelta,
  });

  factory Spread.fromJson(Map<String, dynamic> json) => Spread(
        format: json['format'] as String?,
        lineId: json['line_id'] as int?,
        eventId: json['event_id'] as String?,
        sportId: json['sport_id'] as int?,
        affiliateId: json['affiliate_id'] as int?,
        dateUpdated: json['date_updated'] == null
            ? null
            : DateTime.parse(json['date_updated'] as String),
        pointSpreadAway: (json['point_spread_away'] as num?)?.toDouble(),
        pointSpreadHome: (json['point_spread_home'] as num?)?.toDouble(),
        pointSpreadAwayDelta:
            (json['point_spread_away_delta'] as num?)?.toDouble(),
        pointSpreadAwayMoney:
            (json['point_spread_away_money'] as num?)?.toDouble(),
        pointSpreadHomeDelta:
            (json['point_spread_home_delta'] as num?)?.toDouble(),
        pointSpreadHomeMoney:
            (json['point_spread_home_money'] as num?)?.toDouble(),
        pointSpreadAwayMoneyDelta:
            (json['point_spread_away_money_delta'] as num?)?.toDouble(),
        pointSpreadHomeMoneyDelta:
            (json['point_spread_home_money_delta'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'format': format,
        'line_id': lineId,
        'event_id': eventId,
        'sport_id': sportId,
        'affiliate_id': affiliateId,
        'date_updated': dateUpdated?.toIso8601String(),
        'point_spread_away': pointSpreadAway,
        'point_spread_home': pointSpreadHome,
        'point_spread_away_delta': pointSpreadAwayDelta,
        'point_spread_away_money': pointSpreadAwayMoney,
        'point_spread_home_delta': pointSpreadHomeDelta,
        'point_spread_home_money': pointSpreadHomeMoney,
        'point_spread_away_money_delta': pointSpreadAwayMoneyDelta,
        'point_spread_home_money_delta': pointSpreadHomeMoneyDelta,
      };
}
