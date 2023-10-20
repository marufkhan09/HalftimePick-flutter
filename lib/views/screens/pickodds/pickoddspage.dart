import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/models/calendermodel.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/pickodds.dart';
import 'package:halftimepick/views/screens/scores/scorespage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/date_symbol_data_local.dart';

class PickOddsPage extends StatefulWidget {
  const PickOddsPage({super.key});

  @override
  State<PickOddsPage> createState() => _PickOddsPageState();
}

class _PickOddsPageState extends State<PickOddsPage> {
  int currentIndex = 0;
  String today = "";
  final SplashController _splashController = Get.find<SplashController>();
  List<GamesTab> games = [
    GamesTab("NFL", false),
    GamesTab("NBA", false),
    GamesTab("MLB", false),
    GamesTab("NHL", false),
    GamesTab("NCAAF", false),
    GamesTab("NCAAB", false),
    GamesTab("WNBA", false)
  ];
  final EventController eventController = Get.put(EventController());

  List<CalenderModel> currentMonth = [];
  List<CalenderModel> calender() {
    initializeDateFormatting();
    DateTime now = DateTime.now();
    currentMonth.clear();

    for (int i = 14; i > 0; i--) {
      DateTime day = now.subtract(Duration(days: i));
      final DateFormat formatter = DateFormat('MMM dd');
      final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
      final String formattedDate = formatter.format(day);
      final String apiFormattedDate = apiFormat.format(day);
      currentMonth.add(CalenderModel(formattedDate, apiFormattedDate, false));
    }

    final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
    final String apiFormattedDate = apiFormat.format(DateTime.now());
    currentMonth.add(CalenderModel("Today", apiFormattedDate, true));
    today = apiFormattedDate;

    for (int i = 1; i <= 15; i++) {
      DateTime day = now.add(Duration(days: i));
      final DateFormat formatter = DateFormat('MMM dd');
      final String formattedDate = formatter.format(day);
      final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
      final String apiFormattedDate = apiFormat.format(day);

      currentMonth.add(CalenderModel(formattedDate, apiFormattedDate, false));
    }

    return currentMonth;
  }

  final SplashController splashController = Get.find<SplashController>();

  @override
  void initState() {
    calender();
    currentGame();

    if (_splashController.currentGame == "NCAAF") {
      eventController.ncaafEventloading.value = false;
      eventController.getNcaafEvents(date: today);
    } else if (_splashController.currentGame == "NFL") {
      eventController.nflEventloading.value = false;
      eventController.getNflEvents(date: today);
    } else if (_splashController.currentGame == "MLB") {
      eventController.mlbEventloading.value = false;
      eventController.getMlbEvents(date: today);
    } else if (_splashController.currentGame == "NBA") {
      eventController.nbaEventloading.value = false;
      eventController.getNbaEvents(date: today);
    } else if (_splashController.currentGame == "NCAAB") {
      eventController.ncaabEventloading.value = false;
      eventController.getNcaabEvents(date: today);
    } else if (_splashController.currentGame == "WNBA") {
      eventController.wnbaEventloading.value = false;
      eventController.getWnbaEvents(date: today);
    } else {
      eventController.nhlEventloading.value = false;
      eventController.getNhlEvents(date: today);
    }
    super.initState();
  }

  currentGame() {
    if (_splashController.currentGame.value.isEmpty &&
        _splashController.currentBottom.value == 2) {
      _splashController.currentGame.value = "NHL";
    }
    games.forEach((element) {
      element.isselected = false;
    });
    games.forEach((element) {
      if (element.name.toLowerCase() ==
          _splashController.currentGame.value.toLowerCase()) {
        element.isselected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            height: 50,
            child: ScrollablePositionedList.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: games.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: games.elementAt(index).isselected == true
                            ? ProjectColors.bottomnavselectedcolor
                            : Colors.black,
                        width: 3.0,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        var selectedgameindex = games.indexWhere(
                            (element) => element.isselected == true);
                        print(selectedgameindex.toString());
                        if (selectedgameindex != -1) {
                          print("index ase");
                          games[selectedgameindex].isselected = false;
                        }

                        games.elementAt(index).isselected = true;

                        var selectedDateIndex = currentMonth.indexWhere(
                            (element) => element.isselected == true);
                        currentMonth.elementAt(selectedDateIndex).isselected =
                            false;
                        var todaysIndex = currentMonth
                            .indexWhere((element) => element.date == "Today");
                        currentMonth.elementAt(todaysIndex).isselected = true;
                        if (games.elementAt(index).name == "NFL") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "NFL";
                          _splashController.update();
                          eventController.nflEventloading.value = false;
                          eventController.update();
                          eventController.getNflEvents(date: today);
                        } else if (games.elementAt(index).name == "NBA") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "NBA";
                          _splashController.update();
                          eventController.nbaEventloading.value = false;
                          eventController.update();
                          eventController.getNbaEvents(date: today);
                        } else if (games.elementAt(index).name == "MLB") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "MLB";
                          _splashController.update();
                          eventController.mlbEventloading.value = false;
                          eventController.update();
                          eventController.getMlbEvents(date: today);
                        } else if (games.elementAt(index).name == "NHL") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "NHL";
                          _splashController.update();
                          eventController.nhlEventloading.value = false;
                          eventController.update();
                          eventController.getNhlEvents(date: today);
                        } else if (games.elementAt(index).name == "NCAAF") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "NCAAF";
                          _splashController.update();
                          eventController.ncaafEventloading.value = false;
                          eventController.update();
                          eventController.getNcaafEvents(date: today);
                        } else if (games.elementAt(index).name == "NCAAB") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "NCAAB";
                          _splashController.update();
                          eventController.ncaabEventloading.value = false;
                          eventController.update();
                          eventController.getNcaabEvents(date: today);
                        } else {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "WNBA";
                          _splashController.update();
                          eventController.wnbaEventloading.value = false;
                          eventController.update();
                          eventController.getWnbaEvents(date: today);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      child: Text(
                        games.elementAt(index).name,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 12,
                            color: games.elementAt(index).isselected == true
                                ? ProjectColors.bottomnavselectedcolor
                                : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            height: 50,
            child: ScrollablePositionedList.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              initialScrollIndex: currentMonth
                      .indexWhere((element) => element.date == "Today") -
                  3,
              itemCount: currentMonth.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    var a = currentMonth
                        .indexWhere((element) => element.isselected == true);
                    setState(() {
                      currentMonth.elementAt(a).isselected = false;
                      currentMonth.elementAt(index).isselected = true;
                    });
                    if (_splashController.currentGame == "NCAAF") {
                      eventController.ncaafEventloading.value = false;
                      eventController.getNcaafEvents(
                          date: currentMonth[index].apiFormattedDate);
                    } else if (_splashController.currentGame == "NFL") {
                      eventController.nflEventloading.value = false;
                      eventController.getNflEvents(
                          date: currentMonth[index].apiFormattedDate);
                    } else if (_splashController.currentGame == "MLB") {
                      eventController.mlbEventloading.value = false;
                      eventController.getMlbEvents(
                          date: currentMonth[index].apiFormattedDate);
                    } else if (_splashController.currentGame == "NBA") {
                      eventController.nbaEventloading.value = false;
                      eventController.getNbaEvents(
                          date: currentMonth[index].apiFormattedDate);
                    } else if (_splashController.currentGame == "NCAAB") {
                      eventController.ncaabEventloading.value = false;
                      eventController.getNcaabEvents(
                          date: currentMonth[index].apiFormattedDate);
                    } else if (_splashController.currentGame == "WNBA") {
                      eventController.wnbaEventloading.value = false;
                      eventController.getWnbaEvents(
                          date: currentMonth[index].apiFormattedDate);
                    } else {
                      eventController.nhlEventloading.value = false;
                      eventController.getNhlEvents(
                          date: currentMonth[index].apiFormattedDate);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: Text(
                        currentMonth.elementAt(index).date,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 11,
                            color: currentMonth[index].isselected == true
                                ? Colors.blue
                                : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          PickTab()
        ],
      ),
    );
  }
}

class Tabs {
  Tabs(this.name, this.isselected);
  String name;
  bool isselected;
}
