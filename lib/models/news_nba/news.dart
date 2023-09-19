class News {
  int? id;
  String? image;
  bool? isMagazine;
  String? publishDate;
  int? sourceId;
  String? title;
  String? url;

  News({
    this.id,
    this.image,
    this.isMagazine,
    this.publishDate,
    this.sourceId,
    this.title,
    this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json['id'] as int?,
        image: json['image'] as String?,
        isMagazine: json['isMagazine'] as bool?,
        publishDate: json['publishDate'] as String?,
        sourceId: json['sourceId'] as int?,
        title: json['title'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'isMagazine': isMagazine,
        'publishDate': publishDate,
        'sourceId': sourceId,
        'title': title,
        'url': url,
      };
}
