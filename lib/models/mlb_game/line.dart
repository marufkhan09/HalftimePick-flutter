import 'affiliate.dart';
import 'moneyline.dart';
import 'spread.dart';
import 'total.dart';

class Line {
  Total? total;
  Spread? spread;
  int? lineId;
  Affiliate? affiliate;
  Moneyline? moneyline;

  Line({
    this.total,
    this.spread,
    this.lineId,
    this.affiliate,
    this.moneyline,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
        spread: json['spread'] == null
            ? null
            : Spread.fromJson(json['spread'] as Map<String, dynamic>),
        lineId: json['line_id'] as int?,
        affiliate: json['affiliate'] == null
            ? null
            : Affiliate.fromJson(json['affiliate'] as Map<String, dynamic>),
        moneyline: json['moneyline'] == null
            ? null
            : Moneyline.fromJson(json['moneyline'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'total': total?.toJson(),
        'spread': spread?.toJson(),
        'line_id': lineId,
        'affiliate': affiliate?.toJson(),
        'moneyline': moneyline?.toJson(),
      };
}
