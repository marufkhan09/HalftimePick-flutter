class Affiliate {
  int? affiliateId;
  String? affiliateUrl;
  String? affiliateName;

  Affiliate({this.affiliateId, this.affiliateUrl, this.affiliateName});

  factory Affiliate.fromJson(Map<String, dynamic> json) => Affiliate(
        affiliateId: json['affiliate_id'] as int?,
        affiliateUrl: json['affiliate_url'] as String?,
        affiliateName: json['affiliate_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'affiliate_id': affiliateId,
        'affiliate_url': affiliateUrl,
        'affiliate_name': affiliateName,
      };
}
