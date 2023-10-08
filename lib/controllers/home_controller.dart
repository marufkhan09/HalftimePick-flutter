import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/base_api_controller.dart';
import 'package:halftimepick/models/all_sports_model/sport.dart';

class HomeController extends BaseApiController {
  final Rx<ScrollController> scontroller = ScrollController().obs;

  Dio dio = Dio();
  List<Sport> gamename = [
    Sport(sportId: 1,sportName: "NCAA Football", ),
    Sport(sportId: 2,sportName: "NFL"),
    Sport(sportId: 3,sportName:"MLB" ),
    Sport(sportId: 4,sportName: "NBA"),
    Sport(sportId: 5,sportName:  "NCAA Men's Basketball"),
    Sport(sportId: 6,sportName: "NHL"),
    Sport(sportId: 8,sportName: "WNBA")
  ];

  // Future getAllGames() async {
  //   try {
  //     var response = await dio.get(
  //       "https://therundown-therundown-v1.p.rapidapi.com/${ApiEndpoints.sports}",
  //       options: Options(headers: {
  //         "X-RapidAPI-Key":
  //             "1e463f0494mshc165327b512b9c9p1fc774jsn5883cfefa8a8",
  //         "X-RapidAPI-Host": "therundown-therundown-v1.p.rapidapi.com"
  //       }),
  //     );
  //     AllSportsModel _sports = AllSportsModel.fromJson(response.data);
  //     allsportsobj.value = _sports;
  //     sports.clear();
  //     sports.addAll(_sports.sports!);
  //     sports.retainWhere((element) {
  //       return element.sportName == "NCAA Football" ||
  //           element.sportName == "NFL" ||
  //           element.sportName == "MLB" ||
  //           element.sportName == "NBA" ||
  //           element.sportName == "NCAA Men's Basketball" ||
  //           element.sportName == "NHL" ||
  //           element.sportName == "WNBA";
  //     });

  //     gameAvailable.value = true;
  //     update();
  //     return sports;
  //   } on DioError catch (e) {
  //         Get.snackbar(
  //         e.response!.statusCode!.toString(), e.response!.data!.toString(),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         margin: const EdgeInsets.all(10));
  //   }
  // }
}
