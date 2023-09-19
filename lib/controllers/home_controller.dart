import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/base_api_controller.dart';
import 'package:halftimepick/models/all_sports_model/all_sports_model.dart';
import 'package:halftimepick/models/all_sports_model/sport.dart';
import 'package:halftimepick/services/api_endpoints.dart';

class HomeController extends BaseApiController {
  final Rx<ScrollController> scontroller = ScrollController().obs;
  RxBool gameAvailable = false.obs;
  Rx<AllSportsModel> allsportsobj = AllSportsModel().obs;
  RxList<Sport> sports = <Sport>[].obs;
  Dio dio = Dio();
  List<String> gamename = [
    "NCAA Football",
    "NFL",
    "MLB",
    "NBA",
    "NCAA Men's Basketball",
    "NHL",
    "WNBA"
  ];

  Future getAllGames() async {
    try {
      var response = await dio.get(
        "https://therundown-therundown-v1.p.rapidapi.com/${ApiEndpoints.sports}",
        options: Options(headers: {
          "X-RapidAPI-Key":
              "1e463f0494mshc165327b512b9c9p1fc774jsn5883cfefa8a8",
          "X-RapidAPI-Host": "therundown-therundown-v1.p.rapidapi.com"
        }),
      );
      AllSportsModel _sports = AllSportsModel.fromJson(response.data);
      allsportsobj.value = _sports;
      sports.clear();
      sports.addAll(_sports.sports!);
      sports.retainWhere((element) {
        return element.sportName == "NCAA Football" ||
            element.sportName == "NFL" ||
            element.sportName == "MLB" ||
            element.sportName == "NBA" ||
            element.sportName == "NCAA Men's Basketball" ||
            element.sportName == "NHL" ||
            element.sportName == "WNBA";
      });

      gameAvailable.value = true;
      update();
      return sports;
    } on DioError catch (e) {
          Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
    }
  }
}
