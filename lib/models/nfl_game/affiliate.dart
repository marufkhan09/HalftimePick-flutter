class Affiliate {
  int? affiliateId;
  String? affiliateName;
  String? affiliateUrl;

  Affiliate({this.affiliateId, this.affiliateName, this.affiliateUrl});

  factory Affiliate.fromJson(Map<String, dynamic> json) => Affiliate(
        affiliateId: json['affiliate_id'] as int?,
        affiliateName: json['affiliate_name'] as String?,
        affiliateUrl: json['affiliate_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'affiliate_id': affiliateId,
        'affiliate_name': affiliateName,
        'affiliate_url': affiliateUrl,
      };
}
