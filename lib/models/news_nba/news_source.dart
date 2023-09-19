class NewsSource {
  int? id;
  int? imageVersion;
  String? name;

  NewsSource({this.id, this.imageVersion, this.name});

  factory NewsSource.fromJson(Map<String, dynamic> json) => NewsSource(
        id: json['id'] as int?,
        imageVersion: json['imageVersion'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageVersion': imageVersion,
        'name': name,
      };
}
