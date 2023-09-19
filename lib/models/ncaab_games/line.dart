import 'affiliate.dart';
import 'moneyline.dart';
import 'spread.dart';
import 'total.dart';

class Line {
  int? lineId;
  Moneyline? moneyline;
  Spread? spread;
  Total? total;
  Affiliate? affiliate;

  Line({
    this.lineId,
    this.moneyline,
    this.spread,
    this.total,
    this.affiliate,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        lineId: json['line_id'] as int?,
        moneyline: json['moneyline'] == null
            ? null
            : Moneyline.fromJson(json['moneyline'] as Map<String, dynamic>),
        spread: json['spread'] == null
            ? null
            : Spread.fromJson(json['spread'] as Map<String, dynamic>),
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
        affiliate: json['affiliate'] == null
            ? null
            : Affiliate.fromJson(json['affiliate'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'line_id': lineId,
        'moneyline': moneyline?.toJson(),
        'spread': spread?.toJson(),
        'total': total?.toJson(),
        'affiliate': affiliate?.toJson(),
      };
}
