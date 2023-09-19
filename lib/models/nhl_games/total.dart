class Total {
  double? totalOver;
  double? totalOverDelta;
  double? totalUnder;
  double? totalUnderDelta;
  double? totalOverMoney;
  double? totalOverMoneyDelta;
  double? totalUnderMoney;
  double? totalUnderMoneyDelta;
  int? lineId;
  String? eventId;
  int? sportId;
  int? affiliateId;
  String? dateUpdated;
  String? format;

  Total({
    this.totalOver,
    this.totalOverDelta,
    this.totalUnder,
    this.totalUnderDelta,
    this.totalOverMoney,
    this.totalOverMoneyDelta,
    this.totalUnderMoney,
    this.totalUnderMoneyDelta,
    this.lineId,
    this.eventId,
    this.sportId,
    this.affiliateId,
    this.dateUpdated,
    this.format,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        totalOver: (json['total_over'] as num?)?.toDouble(),
        totalOverDelta: (json['total_over_delta'] as num?)?.toDouble(),
        totalUnder: (json['total_under'] as num?)?.toDouble(),
        totalUnderDelta: (json['total_under_delta'] as num?)?.toDouble(),
        totalOverMoney: (json['total_over_money'] as num?)?.toDouble(),
        totalOverMoneyDelta:
            (json['total_over_money_delta'] as num?)?.toDouble(),
        totalUnderMoney: (json['total_under_money'] as num?)?.toDouble(),
        totalUnderMoneyDelta:
            (json['total_under_money_delta'] as num?)?.toDouble(),
        lineId: json['line_id'] as int?,
        eventId: json['event_id'] as String?,
        sportId: json['sport_id'] as int?,
        affiliateId: json['affiliate_id'] as int?,
        dateUpdated: json['date_updated'] as String?,
        format: json['format'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'total_over': totalOver,
        'total_over_delta': totalOverDelta,
        'total_under': totalUnder,
        'total_under_delta': totalUnderDelta,
        'total_over_money': totalOverMoney,
        'total_over_money_delta': totalOverMoneyDelta,
        'total_under_money': totalUnderMoney,
        'total_under_money_delta': totalUnderMoneyDelta,
        'line_id': lineId,
        'event_id': eventId,
        'sport_id': sportId,
        'affiliate_id': affiliateId,
        'date_updated': dateUpdated,
        'format': format,
      };
}
