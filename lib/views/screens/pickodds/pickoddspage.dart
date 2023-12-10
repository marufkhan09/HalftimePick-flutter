import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/models/calendermodel.dart';
import 'package:halftimepick/models/weekmode.dart';
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
  late DateTime currentNcaafWeek;
  late DateTime ncaafStartDate;
  late DateTime ncaafEndDate;
  List<WeekModel> ncaafweekModels = [];

  late DateTime currentNflWeek;
  List<WeekModel> nflweekModels = [];
  late DateTime nflstartDate;
  late DateTime nflEndDate;
  late DateFormat dateFormat;
  late DateTime nflWeekStartDate;
  late DateTime nflWeekEndDate;
  late DateTime ncaafWeekStartDate;
  late DateTime ncaafWeekEndDate;

  String returnDay(DateTime date) {
    var outputFormat = DateFormat('dd MMM');
    var output = outputFormat.format(date.toLocal());

    return output.toString();
  }

  List<CalenderModel> calender() {
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

  nflCalender() {
    while (currentNflWeek.isBefore(nflEndDate)) {
      List<DateTime> days = [];
      currentNflWeek =
          findNextThursday(currentNflWeek); // Find the next Thursday
      for (int i = 0; i < 5; i++) {
        // Iterate 5 days (Thursday to Monday)
        days.add(currentNflWeek);
        currentNflWeek = currentNflWeek.add(Duration(days: 1));
      }

      WeekModel week = WeekModel(
          isSelected: false, // You can set this value as needed
          days: days,
          startDate: days.first,
          endDate: days.last);

      nflweekModels.add(week);

      currentNflWeek =
          currentNflWeek.add(Duration(days: 2)); // Skip Monday to Wednesday
    }
    print(nflweekModels);
  }

  ncaafCalender() {
    while (currentNcaafWeek.isBefore(ncaafEndDate)) {
      List<DateTime> days = [];
      currentNcaafWeek =
          findNextTuesday(currentNcaafWeek); // Find the next Thursday
      for (int i = 0; i < 5; i++) {
        // Iterate 4 days (Tuesday to Saturday)
        days.add(currentNcaafWeek);
        currentNcaafWeek = currentNcaafWeek.add(Duration(days: 1));
      }

      WeekModel week = WeekModel(
          isSelected: false, // You can set this value as needed
          days: days,
          startDate: days.first,
          endDate: days.last);

      ncaafweekModels.add(week);

      currentNcaafWeek =
          currentNcaafWeek.add(Duration(days: 2)); // Skip Monday to Wednesday
    }
  }

  DateTime findNextThursday(DateTime date) {
    while (date.weekday != DateTime.thursday) {
      date = date.add(Duration(days: 1));
    }
    return date;
  }

  DateTime findNextTuesday(DateTime date) {
    while (date.weekday != DateTime.tuesday) {
      date = date.add(Duration(days: 1));
    }
    return date;
  }

  final SplashController splashController = Get.find<SplashController>();

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat("yyyy-MM-dd");
    currentGame();
    nflstartDate = dateFormat.parse('2023-09-07');
    nflEndDate = dateFormat.parse('2024-02-11');
    ncaafStartDate = dateFormat.parse('2023-08-26');
    ncaafEndDate = dateFormat.parse('2023-12-10');
    currentNflWeek = nflstartDate;
    currentNcaafWeek = ncaafStartDate;
    ncaafCalender();
    getCurrentNcaafWeek(ncaafweekModels, DateTime.now());
    nflCalender();
    getCurrentNflWeek(nflweekModels, DateTime.now());
    calender();

    if (_splashController.currentGame.value == "NCAAF") {
      eventController.ncaafEventloading.value = false;
      eventController.getNcaafEvents(
          startDate: ncaafWeekStartDate, endDate: ncaafWeekEndDate);
    } else if (_splashController.currentGame.value == "NFL") {
      eventController.nflEventloading.value = false;
      eventController.getNflEvents(
          startDate: nflWeekStartDate, endDate: nflWeekEndDate);
    } else if (_splashController.currentGame.value == "MLB") {
      eventController.mlbEventloading.value = false;
      eventController.getMlbEvents(date: today);
    } else if (_splashController.currentGame.value == "NBA") {
      eventController.nbaEventloading.value = false;
      eventController.getNbaEvents(date: today);
    } else if (_splashController.currentGame.value == "NCAAB") {
      eventController.ncaabEventloading.value = false;
      eventController.getNcaabEvents(date: today);
    } else if (_splashController.currentGame.value == "WNBA") {
      eventController.wnbaEventloading.value = false;
      eventController.getWnbaEvents(date: today);
    } else {
      eventController.nhlEventloading.value = false;
      eventController.getNhlEvents(date: today);
    }
    super.initState();
  }

  getCurrentNflWeek(List<WeekModel> weekModels, DateTime currentDate) {
    var a = weekModels.indexWhere((element) =>
        currentDate.isBefore(element.endDate.add(Duration(days: 1))));
    print(a);

    if (a != -1) {
      weekModels.elementAt(a).isSelected = true;
      nflWeekStartDate = weekModels.elementAt(a).startDate;
      nflWeekEndDate = weekModels.elementAt(a).endDate;
    }
  }

  getCurrentNcaafWeek(List<WeekModel> weekModels, DateTime currentDate) {
    var a = weekModels.indexWhere((element) =>
        currentDate.isBefore(element.endDate.add(Duration(days: 1))));
    print(a);
    if (a != -1) {
      weekModels.elementAt(a).isSelected = true;
      ncaafWeekStartDate = weekModels.elementAt(a).startDate;
      ncaafWeekEndDate = weekModels.elementAt(a).endDate;
    }
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
                        games.forEach((element) {
                          element.isselected = false;
                          games.elementAt(index).isselected = true;
                          _splashController.currentGame.value =
                              games.elementAt(index).name;
                        });
                        if (_splashController.currentGame.value != "NFL" ||
                            _splashController.currentGame.value != "NCAAF") {
                          var todaysIndex = currentMonth
                              .indexWhere((element) => element.date == "Today");
                          currentMonth.elementAt(todaysIndex).isselected = true;
                        }
                        if (_splashController.currentGame.value == "NCAAF") {
                          currentNcaafWeek = ncaafStartDate;
                          ncaafweekModels.forEach((element) {
                            element.isSelected = false;
                          });
                          getCurrentNcaafWeek(ncaafweekModels, DateTime.now());
                        }
                        if (_splashController.currentGame.value == "NFL") {
                          currentNflWeek = nflstartDate;
                          nflweekModels.forEach((element) {
                            element.isSelected = false;
                          });
                          getCurrentNflWeek(nflweekModels, DateTime.now());
                        }
                        if (games.elementAt(index).name == "NFL") {
                          _splashController.currentBottom.value = 2;
                          _splashController.currentGame.value = "NFL";
                          _splashController.update();
                          eventController.nflEventloading.value = false;
                          eventController.update();
                          eventController.getNflEvents(
                              startDate: nflWeekStartDate,
                              endDate: nflWeekEndDate);
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
                          eventController.getNcaafEvents(
                              startDate: ncaafWeekStartDate,
                              endDate: ncaafWeekEndDate);
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
                      width: 64,
                      child: Text(
                        games.elementAt(index).name,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14,
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
          _splashController.currentGame.value != "NCAAF" &&
                  _splashController.currentGame.value != "NFL"
              ? Container(
                  color: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          var a = currentMonth.indexWhere(
                              (element) => element.isselected == true);
                          setState(() {
                            currentMonth.elementAt(a).isselected = false;
                            currentMonth.elementAt(index).isselected = true;
                          });
                          if (_splashController.currentGame == "NCAAF") {
                            eventController.ncaafEventloading.value = false;
                          } else if (_splashController.currentGame == "NFL") {
                            eventController.nflEventloading.value = false;
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
                            width: 54,
                            child: Text(
                              currentMonth.elementAt(index).date,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12,
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
                )
              : const SizedBox.shrink(),
          _splashController.currentGame.value == "NFL"
              ? Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 54,
                  child: ScrollablePositionedList.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    initialScrollIndex: nflweekModels
                        .indexWhere((element) => element.isSelected == true),
                    itemCount: nflweekModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            nflweekModels.forEach((element) {
                              element.isSelected = false;
                            });
                            nflweekModels.elementAt(index).isSelected = true;
                            eventController.nflEventloading.value = false;
                            eventController.update();
                            eventController.getNflEvents(
                                startDate:
                                    nflweekModels.elementAt(index).startDate,
                                endDate:
                                    nflweekModels.elementAt(index).endDate);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Week ${index + 1}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: nflweekModels[index].isSelected ==
                                              true
                                          ? Colors.blue
                                          : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "${returnDay(nflweekModels.elementAt(index).startDate)} - ${returnDay(nflweekModels.elementAt(index).endDate)}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: nflweekModels[index].isSelected ==
                                              true
                                          ? Colors.blue
                                          : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
          _splashController.currentGame.value == "NCAAF"
              ? Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 54,
                  child: ScrollablePositionedList.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    initialScrollIndex: ncaafweekModels
                        .indexWhere((element) => element.isSelected == true),
                    itemCount: ncaafweekModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            ncaafweekModels.forEach((element) {
                              element.isSelected = false;
                            });
                            ncaafweekModels.elementAt(index).isSelected = true;
                            eventController.ncaafEventloading.value = false;
                            eventController.update();
                            eventController.getNcaafEvents(
                                startDate:
                                    ncaafweekModels.elementAt(index).startDate,
                                endDate:
                                    ncaafweekModels.elementAt(index).endDate);
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                child: Text(
                                  "Week ${index + 1}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          ncaafweekModels[index].isSelected ==
                                                  true
                                              ? Colors.blue
                                              : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Text(
                              "${returnDay(ncaafweekModels.elementAt(index).startDate)} - ${returnDay(ncaafweekModels.elementAt(index).endDate)}",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 9,
                                  color:
                                      ncaafweekModels[index].isSelected == true
                                          ? Colors.blue
                                          : Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(),
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
