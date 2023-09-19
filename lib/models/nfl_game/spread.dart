class Spread {
  double? pointSpreadAway;
  double? pointSpreadHome;
  double? pointSpreadAwayDelta;
  double? pointSpreadHomeDelta;
  double? pointSpreadAwayMoney;
  double? pointSpreadAwayMoneyDelta;
  double? pointSpreadHomeMoney;
  double? pointSpreadHomeMoneyDelta;
  int? lineId;
  String? eventId;
  int? sportId;
  int? affiliateId;
  String? dateUpdated;
  String? format;

  Spread({
    this.pointSpreadAway,
    this.pointSpreadHome,
    this.pointSpreadAwayDelta,
    this.pointSpreadHomeDelta,
    this.pointSpreadAwayMoney,
    this.pointSpreadAwayMoneyDelta,
    this.pointSpreadHomeMoney,
    this.pointSpreadHomeMoneyDelta,
    this.lineId,
    this.eventId,
    this.sportId,
    this.affiliateId,
    this.dateUpdated,
    this.format,
  });

  factory Spread.fromJson(Map<String, dynamic> json) => Spread(
        pointSpreadAway: (json['point_spread_away'] as num?)?.toDouble(),
        pointSpreadHome: (json['point_spread_home'] as num?)?.toDouble(),
        pointSpreadAwayDelta:
            (json['point_spread_away_delta'] as num?)?.toDouble(),
        pointSpreadHomeDelta:
            (json['point_spread_home_delta'] as num?)?.toDouble(),
        pointSpreadAwayMoney:
            (json['point_spread_away_money'] as num?)?.toDouble(),
        pointSpreadAwayMoneyDelta:
            (json['point_spread_away_money_delta'] as num?)?.toDouble(),
        pointSpreadHomeMoney:
            (json['point_spread_home_money'] as num?)?.toDouble(),
        pointSpreadHomeMoneyDelta:
            (json['point_spread_home_money_delta'] as num?)?.toDouble(),
        lineId: json['line_id'] as int?,
        eventId: json['event_id'] as String?,
        sportId: json['sport_id'] as int?,
        affiliateId: json['affiliate_id'] as int?,
        dateUpdated: json['date_updated'] as String?,
        format: json['format'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'point_spread_away': pointSpreadAway,
        'point_spread_home': pointSpreadHome,
        'point_spread_away_delta': pointSpreadAwayDelta,
        'point_spread_home_delta': pointSpreadHomeDelta,
        'point_spread_away_money': pointSpreadAwayMoney,
        'point_spread_away_money_delta': pointSpreadAwayMoneyDelta,
        'point_spread_home_money': pointSpreadHomeMoney,
        'point_spread_home_money_delta': pointSpreadHomeMoneyDelta,
        'line_id': lineId,
        'event_id': eventId,
        'sport_id': sportId,
        'affiliate_id': affiliateId,
        'date_updated': dateUpdated,
        'format': format,
      };
}
