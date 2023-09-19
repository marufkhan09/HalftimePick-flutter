class Total {
  String? format;
  int? lineId;
  String? eventId;
  int? sportId;
  double? totalOver;
  double? totalUnder;
  int? affiliateId;
  DateTime? dateUpdated;
  double? totalOverDelta;
  double? totalOverMoney;
  double? totalUnderDelta;
  double? totalUnderMoney;
  double? totalOverMoneyDelta;
  double? totalUnderMoneyDelta;

  Total({
    this.format,
    this.lineId,
    this.eventId,
    this.sportId,
    this.totalOver,
    this.totalUnder,
    this.affiliateId,
    this.dateUpdated,
    this.totalOverDelta,
    this.totalOverMoney,
    this.totalUnderDelta,
    this.totalUnderMoney,
    this.totalOverMoneyDelta,
    this.totalUnderMoneyDelta,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        format: json['format'] as String?,
        lineId: json['line_id'] as int?,
        eventId: json['event_id'] as String?,
        sportId: json['sport_id'] as int?,
        totalOver: (json['total_over'] as num?)?.toDouble(),
        totalUnder: (json['total_under'] as num?)?.toDouble(),
        affiliateId: json['affiliate_id'] as int?,
        dateUpdated: json['date_updated'] == null
            ? null
            : DateTime.parse(json['date_updated'] as String),
        totalOverDelta: (json['total_over_delta'] as num?)?.toDouble(),
        totalOverMoney: (json['total_over_money'] as num?)?.toDouble(),
        totalUnderDelta: (json['total_under_delta'] as num?)?.toDouble(),
        totalUnderMoney: (json['total_under_money'] as num?)?.toDouble(),
        totalOverMoneyDelta:
            (json['total_over_money_delta'] as num?)?.toDouble(),
        totalUnderMoneyDelta:
            (json['total_under_money_delta'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'format': format,
        'line_id': lineId,
        'event_id': eventId,
        'sport_id': sportId,
        'total_over': totalOver,
        'total_under': totalUnder,
        'affiliate_id': affiliateId,
        'date_updated': dateUpdated?.toIso8601String(),
        'total_over_delta': totalOverDelta,
        'total_over_money': totalOverMoney,
        'total_under_delta': totalUnderDelta,
        'total_under_money': totalUnderMoney,
        'total_over_money_delta': totalOverMoneyDelta,
        'total_under_money_delta': totalUnderMoneyDelta,
      };
}
