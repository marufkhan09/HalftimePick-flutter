import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/base_api_controller.dart';
import 'package:halftimepick/models/mlb_game/datum.dart';
import 'package:halftimepick/models/mlb_game/mlb_game.dart';
import 'package:halftimepick/models/nba_games/datum.dart';
import 'package:halftimepick/models/nba_games/nba_games.dart';
import 'package:halftimepick/models/ncaab_games/datum.dart';
import 'package:halftimepick/models/ncaab_games/ncaab_games.dart';
import 'package:halftimepick/models/ncaaf_games/datum.dart';
import 'package:halftimepick/models/ncaaf_games/ncaaf_games.dart';
import 'package:halftimepick/models/news_nhl/news.dart';
import 'package:halftimepick/models/nfl_game/datum.dart';
import 'package:halftimepick/models/nfl_game/nfl_game.dart';
import 'package:halftimepick/models/nhl_games/datum.dart';
import 'package:halftimepick/models/nhl_games/nhl_games.dart';
import 'package:halftimepick/models/wnba_games/datum.dart';
import 'package:halftimepick/models/wnba_games/wnba_games.dart';

class EventController extends BaseApiController {
  //Dio dio = Dio();
  final Rx<ScrollController> scontroller = ScrollController().obs;
  RxList<dynamic> keysList = [].obs;

  RxList<nhlLNewsList> nhlnewslist = <nhlLNewsList>[].obs;
  //sports id: 1 ncaaf
  RxBool ncaafEventloading = false.obs;
  Rx<NcaafGames> ncaafGame = NcaafGames().obs;
  RxList<NcaafGamesData> ncaafgamedata = <NcaafGamesData>[].obs;
  //sports id: 2 nfl
  RxBool nflEventloading = false.obs;
  Rx<NflGame> nflGame = NflGame().obs;
  RxList<NflGameData> nflgamedata = <NflGameData>[].obs;
  //sports id: 3 mlb
  RxBool mlbEventloading = false.obs;
  Rx<MlbGame> mlbGame = MlbGame().obs;
  RxList<MlbGameData> mlbgamedata = <MlbGameData>[].obs;
  //sports id: 4 nba
  RxBool nbaEventloading = false.obs;
  Rx<NbaGames> nbaGame = NbaGames().obs;
  RxList<NbaGamesData> nbagamedata = <NbaGamesData>[].obs;
  //sports id: 5 ncaab
  RxBool ncaabEventloading = false.obs;
  Rx<NcaabGames> ncaabGame = NcaabGames().obs;
  RxList<NcaabGamesData> ncaabgamedata = <NcaabGamesData>[].obs;

  //sports id: 6 ncaab
  RxBool nhlEventloading = false.obs;
  Rx<NhlGames> nhlGame = NhlGames().obs;
  RxList<NhlGamesData> nhlgamedata = <NhlGamesData>[].obs;

  //sports id: 8 wnba
  RxBool wnbaEventloading = false.obs;
  Rx<WnbaGames> wnbaGame = WnbaGames().obs;
  RxList<WnbaGamesData> wnbagamedata = <WnbaGamesData>[].obs;

  //game id : 1 ncaaf
  Future<List<NcaafGamesData>> getNcaafEvents({required String date}) async {
    try {
      var response = await getDio()!.get(
        "1/events/$date",
      );
      //  https: //halftimepick.accountta.com/api/2/events/2020-09-20
      NcaafGames ncaaf = NcaafGames.fromJson(response.data);
      ncaafGame.value = ncaaf;
      ncaafgamedata.clear();
      ncaafgamedata.value = ncaafGame.value.data!;
      ncaafEventloading.value = true;
      update();
      print(response.toString());
      return ncaafgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NcaafGamesData>[];
    }
  }

  //game id : 3 mlb
  Future<List<MlbGameData>> getMlbEvents({required String date}) async {
    try {
      //https://halftimepick.laravel-script.com/api/3/events/2023-07-23
      var response = await getDio()!.get(
        "3/events/$date",
      );
      MlbGame mlb = MlbGame.fromJson(response.data);
      mlbGame.value = mlb;
      mlbgamedata.clear();
      mlbgamedata.value = mlbGame.value.data!;
      mlbEventloading.value = true;
      update();
      return mlbgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <MlbGameData>[];
    }
  }

  //game id : 4 nba
  Future<List<NbaGamesData>> getNbaEvents({required String date}) async {
    try {
      //https://halftimepick.laravel-script.com/api/3/events/2023-07-23
      var response = await getDio()!.get(
        "4/events/$date",
      );
      NbaGames nba = NbaGames.fromJson(response.data);
      nbaGame.value = nba;
      nbagamedata.clear();
      nbagamedata.value = nbaGame.value.data!;
      nbaEventloading.value = true;
      update();
      return nbagamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NbaGamesData>[];
    }
  }

  //game id : 6 nhl

  Future<List<NhlGamesData>> getNhlEvents({required String date}) async {
    try {
      //https://halftimepick.laravel-script.com/api/3/events/2023-07-23
      var response = await getDio()!.get(
        "6/events/$date",
      );
      //https://halftimepick.accountta.com/api/2/events/2020-09-20
      NhlGames nhl = NhlGames.fromJson(response.data);
      nhlGame.value = nhl;
      nhlgamedata.clear();
      nhlgamedata.value = nhlGame.value.data!;
      nhlEventloading.value = true;
      update();
      return nhlgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NhlGamesData>[];
    }
  }

  //game id :  nfl
  Future<List<NflGameData>> getNflEvents({required String date}) async {
    try {
      var response = await getDio()!.get(
        "2/events/$date",
      );
      NflGame nfl = NflGame.fromJson(response.data);
      nflGame.value = nfl;
      nflgamedata.clear();
      nflgamedata.value = nflGame.value.data!;
      nflEventloading.value = true;
      update();
      return nflgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NflGameData>[];
    }
  }

  //game id : 5 ncaab
  Future<List<NcaabGamesData>> getNcaabEvents({required String date}) async {
    try {
      //https://halftimepick.laravel-script.com/api/3/events/2023-07-23
      var response = await getDio()!.get(
        "5/events/$date",
      );
      NcaabGames ncaab = NcaabGames.fromJson(response.data);
      ncaabGame.value = ncaab;
      ncaabgamedata.clear();
      ncaabgamedata.value = ncaabGame.value.data!;
      ncaabEventloading.value = true;
      update();
      return ncaabgamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <NcaabGamesData>[];
    }
  }

  //game id : 5 ncaab
  Future<List<WnbaGamesData>> getWnbaEvents({required String date}) async {
    try {
      var response = await getDio()!.get(
        "8/events/$date",
      );
      WnbaGames wnba = WnbaGames.fromJson(response.data);
      wnbaGame.value = wnba;
      wnbagamedata.clear();
      wnbagamedata.value = wnbaGame.value.data!;
      wnbaEventloading.value = true;
      update();
      return wnbagamedata;
    } on DioError catch (e) {
      Get.snackbar(
          e.response!.statusCode!.toString(), e.response!.data!.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10));
      return <WnbaGamesData>[];
    }
  }
}
