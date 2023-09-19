import 'sport.dart';

class AllSportsModel {
  List<Sport>? sports;

  AllSportsModel({this.sports});

  factory AllSportsModel.fromJson(Map<String, dynamic> json) {
    return AllSportsModel(
      sports: (json['sports'] as List<dynamic>?)
          ?.map((e) => Sport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'sports': sports?.map((e) => e.toJson()).toList(),
      };
}
