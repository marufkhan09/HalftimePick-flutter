import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/models/news_nba/news_nba.dart';
import 'package:halftimepick/models/news_nhl/news.dart';
import 'package:halftimepick/models/news_nhl/news_nhl.dart';

import '../models/news_nba/news.dart';

class NewsController extends GetxController {
  Dio? dio = Dio();
  final Rx<ScrollController> scontroller = ScrollController().obs;
  RxBool nbanewsAvailable = false.obs;
  Rx<NewsNba> nbanewsobj = NewsNba().obs;
  RxList<News> nbanewslist = <News>[].obs;

  RxBool nhlnewsAvailable = false.obs;
  Rx<NhlNewsModel> nhlnewsobj = NhlNewsModel().obs;
  RxList<nhlLNewsList> nhlnewslist = <nhlLNewsList>[].obs;

  Future getNBANews() async {
    try {
      var response = await dio!
          .get("https://allscores.p.rapidapi.com/api/allscores/news?sport=2",
              options: Options(headers: {
                "X-RapidAPI-Key":
                    "1e463f0494mshc165327b512b9c9p1fc774jsn5883cfefa8a8",
                "X-RapidAPI-Host": "allscores.p.rapidapi.com"
              }));

      NewsNba news = NewsNba.fromJson(
        response.data,
      );
      nbanewsobj.value = news;
      nbanewslist.clear();
      nbanewslist.addAll(nbanewsobj.value.news!);
      if (kDebugMode) {
        print("NBA LEN:::${nbanewslist.length}");
      }
      nbanewsAvailable.value = true;
      update();
      return nbanewslist;
    } on DioError catch (e) {
      Get.snackbar("Failed to load data", e.response!.data.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
    }
  }

  Future getNHLNews() async {
    try {
      var response = await dio!
          .get("https://allscores.p.rapidapi.com/api/allscores/news?sport=4",
              options: Options(headers: {
                "X-RapidAPI-Key":
                    "1e463f0494mshc165327b512b9c9p1fc774jsn5883cfefa8a8",
                "X-RapidAPI-Host": "allscores.p.rapidapi.com"
              }));

      NhlNewsModel news = NhlNewsModel.fromJson(response.data);
      nhlnewsobj.value = news;
      nhlnewslist.clear();
      nhlnewslist.addAll(nhlnewsobj.value.news!);
      if (kDebugMode) {
        print("NHL LEN::::${nhlnewslist.length}");
      }
      nhlnewsAvailable.value = true;
      update();
      return nhlnewslist;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
    }
  }
/* 
  Future<List<nhlLNewsList>> nhlNewsReadJson() async {
    final String response =
        await rootBundle.loadString('assets/jsonfiles/allScore-news-nhl.json');
    final Map<String, dynamic> data = await json.decode(response);

    NhlNewsModel news = NhlNewsModel.fromJson(data);
    nhlnewsobj.value = news;
    nhlnewslist.clear();
    nhlnewslist.addAll(nhlnewsobj.value.news!);
    print(nhlnewslist.length.toString());
    nhlnewsAvailable.value = true;
    update();
    return nhlnewslist;
  } */

  // @override
  // void onInit() {
  //   getToken();
  //   super.onInit();
  // }
}
