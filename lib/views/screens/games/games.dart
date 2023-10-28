import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/models/calendermodel.dart';
import 'package:halftimepick/models/weekmode.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/dimensions.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/views/screens/scores/scoreItem.dart';
import 'package:halftimepick/views/screens/scores/scorespage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SpecificGamesPage extends StatefulWidget {
  const SpecificGamesPage({super.key});

  @override
  State<SpecificGamesPage> createState() => _SpecificGamesPageState();
}
// NFL are
// Thursday-Monday

// NCAAF are
// Tuesday- Saturday

class _SpecificGamesPageState extends State<SpecificGamesPage> {
  String today = "";
  final SplashController _splashController = Get.find<SplashController>();
  final EventController eventController = Get.put(EventController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> gameKey = GlobalKey();
  late DateTime currentNflWeek;
  late DateTime currentNcaafWeek;
  late DateTime nflstartDate;
  late DateTime nflEndDate;
  late DateTime ncaafStartDate;
  late DateTime ncaafEndDate;
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  List<WeekModel> nflweekModels = [];
  List<WeekModel> ncaafweekModels = [];
  late WeekModel thisNcaafWeek;
  late WeekModel thisNflWeek;

  List<GamesTab> games = [
    GamesTab("NFL", false),
    GamesTab("NBA", false),
    GamesTab("MLB", false),
    GamesTab("NHL", false),
    GamesTab("NCAAF", false),
    GamesTab("NCAAB", false),
    GamesTab("WNBA", false)
  ];

  currentGame() {
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

  String returnDay(DateTime date) {
    var outputFormat = DateFormat('dd MMM');
    var output = outputFormat.format(date.toLocal());

    return output.toString();
  }

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

  WeekModel getCurrentWeek(List<WeekModel> weekModels, DateTime currentDate) {
    var a = weekModels.indexWhere((element) =>
        currentDate.isBefore(element.endDate.add(Duration(days: 1))));
    print(a);
    weekModels.elementAt(a).isSelected = true;
    return WeekModel(
        isSelected: false, // Default value if no current week is found
        days: [],
        startDate: DateTime.now(),
        endDate: DateTime.now() // Empty list of days
        );
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

  @override
  void initState() {
    currentGame();
    nflstartDate = dateFormat.parse('2023-09-07');
    nflEndDate = dateFormat.parse('2024-02-11');
    ncaafStartDate = dateFormat.parse('2023-08-26');
    ncaafEndDate = dateFormat.parse('2023-12-10');
    currentNflWeek = nflstartDate;
    currentNcaafWeek = ncaafStartDate;
    ncaafCalender();
    thisNcaafWeek = getCurrentWeek(ncaafweekModels, DateTime.now());
    thisNcaafWeek.isSelected = true;
    nflCalender();
    thisNflWeek = getCurrentWeek(nflweekModels, DateTime.now());
    thisNflWeek.isSelected = true;
    calender();

    // if (_splashController.currentGame.value == "NCAAF") {
    //   eventController.ncaafEventloading.value = false;
    //   eventController.getNcaafEvents(date: today);
    // } else if (_splashController.currentGame.value == "NFL") {
    //   eventController.nflEventloading.value = false;
    //   eventController.getNflEvents(date: today);
    // } else if (_splashController.currentGame.value == "MLB") {
    //   eventController.mlbEventloading.value = false;
    //   eventController.getMlbEvents(date: today);
    // } else if (_splashController.currentGame.value == "NBA") {
    //   eventController.nbaEventloading.value = false;
    //   eventController.getNbaEvents(date: today);
    // } else if (_splashController.currentGame.value == "NCAAB") {
    //   eventController.ncaabEventloading.value = false;
    //   eventController.getNcaabEvents(date: today);
    // } else if (_splashController.currentGame.value == "WNBA") {
    //   eventController.wnbaEventloading.value = false;
    //   eventController.getWnbaEvents(date: today);
    // } else {
    //   eventController.nhlEventloading.value = false;
    //   eventController.getNhlEvents(date: today);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ProjectColors.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset("assets/images/logo.svg"),
            )
          ],
        ),
        centerTitle: false,
        titleSpacing: 0.0,
      ),
      body: SingleChildScrollView(
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
                          print("vaL::" + _splashController.currentGame.value);

                          if (_splashController.currentGame.value != "NFL" ||
                              _splashController.currentGame.value != "NCAAF") {
                            var todaysIndex = currentMonth.indexWhere(
                                (element) => element.date == "Today");
                            currentMonth.elementAt(todaysIndex).isselected =
                                true;
                          }
                          if (_splashController.currentGame.value == "NCAAF") {
                            currentNcaafWeek = ncaafStartDate;
                            ncaafweekModels.forEach((element) {
                              element.isSelected = false;
                            });
                            thisNcaafWeek =
                                getCurrentWeek(ncaafweekModels, DateTime.now());
                            thisNcaafWeek.isSelected = true;
                          }
                          if (_splashController.currentGame.value == "NFL") {
                            currentNflWeek = nflstartDate;
                            nflweekModels.forEach((element) {
                              element.isSelected = false;
                            });
                            thisNflWeek =
                                getCurrentWeek(nflweekModels, DateTime.now());
                            thisNflWeek.isSelected = true;
                          }
                        });
                        /*   setState(() {
                          games.forEach((element) {
                            element.isselected = false;
                          });

                          games.elementAt(index).isselected = true;

                          if (_splashController.currentGame.value != "NFL" ||
                              _splashController.currentGame.value != "NCAAF") {
                            var todaysIndex = currentMonth.indexWhere(
                                (element) => element.date == "Today");
                            currentMonth.elementAt(todaysIndex).isselected =
                                true;
                          }
                           else if (_splashController.currentGame.value ==
                              "NCAAF") {
                            ncaafweekModels.forEach((element) {
                              element.isSelected = false;
                            });

                            thisNcaafWeek =
                                getCurrentWeek(ncaafweekModels, DateTime.now());
                            print(thisNcaafWeek);
                            thisNcaafWeek.isSelected = true;
                            print(thisNcaafWeek.isSelected);
                          }
                          if (games.elementAt(index).name == "NFL") {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "NFL";
                            _splashController.update();
                            eventController.nflEventloading.value = false;
                            eventController.update();
                            //  eventController.getNflEvents(date: today);
                          } else if (games.elementAt(index).name == "NBA") {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "NBA";
                            _splashController.update();
                            eventController.nbaEventloading.value = false;
                            eventController.update();
                            //  eventController.getNbaEvents(date: today);
                          } else if (games.elementAt(index).name == "MLB") {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "MLB";
                            _splashController.update();
                            eventController.mlbEventloading.value = false;
                            eventController.update();
                            //  eventController.getMlbEvents(date: today);
                          } else if (games.elementAt(index).name == "NHL") {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "NHL";
                            _splashController.update();
                            eventController.nhlEventloading.value = false;
                            eventController.update();
                            //  eventController.getNhlEvents(date: today);
                          } else if (games.elementAt(index).name == "NCAAF") {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "NCAAF";
                            _splashController.update();
                            eventController.ncaafEventloading.value = false;
                            eventController.update();
                            //  eventController.getNcaafEvents(date: today);
                          } else if (games.elementAt(index).name == "NCAAB") {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "NCAAB";
                            _splashController.update();
                            eventController.ncaabEventloading.value = false;
                            eventController.update();
                            //  eventController.getNcaabEvents(date: today);
                          } else {
                            _splashController.currentBottom.value = 0;
                            _splashController.currentGame.value = "WNBA";
                            _splashController.update();
                            eventController.wnbaEventloading.value = false;
                            eventController.update();
                            //  eventController.getWnbaEvents(date: today);
                          }
                        }); */
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
            _splashController.currentGame.value != "NCAAF" &&
                    _splashController.currentGame.value != "NFL"
                ? Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: double.infinity,
                    height: 50,
                    child: ScrollablePositionedList.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      initialScrollIndex: currentMonth.indexWhere(
                              (element) => element.date == "Today") -
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
                            if (_splashController.currentGame.value ==
                                "NCAAF") {
                              eventController.ncaafEventloading.value = false;
                              eventController.getNcaafEvents(
                                  date: currentMonth[index].apiFormattedDate);
                            } else if (_splashController.currentGame.value ==
                                "NFL") {
                              eventController.nflEventloading.value = false;
                              eventController.getNflEvents(
                                  date: currentMonth[index].apiFormattedDate);
                            } else if (_splashController.currentGame.value ==
                                "MLB") {
                              eventController.mlbEventloading.value = false;
                              eventController.getMlbEvents(
                                  date: currentMonth[index].apiFormattedDate);
                            } else if (_splashController.currentGame.value ==
                                "NBA") {
                              eventController.nbaEventloading.value = false;
                              eventController.getNbaEvents(
                                  date: currentMonth[index].apiFormattedDate);
                            } else if (_splashController.currentGame.value ==
                                "NCAAB") {
                              eventController.ncaabEventloading.value = false;
                              eventController.getNcaabEvents(
                                  date: currentMonth[index].apiFormattedDate);
                            } else if (_splashController.currentGame.value ==
                                "WNBA") {
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
                                    color:
                                        currentMonth[index].isselected == true
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: double.infinity,
                    height: 46,
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
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              alignment: Alignment.center,
                              width: 70,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Week ${index + 1}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color:
                                            nflweekModels[index].isSelected ==
                                                    true
                                                ? Colors.blue
                                                : Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${returnDay(nflweekModels.elementAt(index).startDate)} - ${returnDay(nflweekModels.elementAt(index).endDate)}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color:
                                            nflweekModels[index].isSelected ==
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: double.infinity,
                    height: 46,
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
                              ncaafweekModels.elementAt(index).isSelected =
                                  true;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  child: Text(
                                    "Week ${index + 1}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 11,
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
                                    fontSize: 8,
                                    color: ncaafweekModels[index].isSelected ==
                                            true
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
            Obx(
              (() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _splashController.currentGame.value == "NCAAB"
                          ? GetBuilder<EventController>(builder: (controller) {
                              return controller.ncaabEventloading.value
                                  ? controller.ncaabgamedata.isNotEmpty
                                      ? ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          primary: false,
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 5,
                                            );
                                          },
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                                child: ScoreItem(
                                              item: controller.ncaabgamedata
                                                  .elementAt(index),
                                            ));
                                          },
                                          itemCount:
                                              controller.ncaabgamedata.length,
                                        )
                                      : Center(
                                          heightFactor: 3,
                                          child: Text(
                                            "No Data Available",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        )
                                  : const Center(
                                      child: CupertinoActivityIndicator(
                                          color: Colors.grey),
                                    );
                            })
                          : _splashController.currentGame.value == "NBA"
                              ? GetBuilder<EventController>(
                                  builder: (controller) {
                                  return controller.nbaEventloading.value
                                      ? controller.nbagamedata.isNotEmpty
                                          ? ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              primary: false,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                  height: 5,
                                                );
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                    child: ScoreItem(
                                                  item: controller.nbagamedata
                                                      .elementAt(index),
                                                ));
                                              },
                                              itemCount:
                                                  controller.nbagamedata.length,
                                            )
                                          : Center(
                                              heightFactor: 3,
                                              child: Text(
                                                "No Data Available",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            )
                                      : const Center(
                                          child: CupertinoActivityIndicator(
                                              color: Colors.grey),
                                        );
                                })
                              : _splashController.currentGame.value == "WNBA"
                                  ? GetBuilder<EventController>(
                                      builder: (controller) {
                                      return controller.wnbaEventloading.value
                                          ? controller.wnbagamedata.isNotEmpty
                                              ? ListView.separated(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox(
                                                      height: 5,
                                                    );
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                        child: ScoreItem(
                                                      item: controller
                                                          .wnbagamedata
                                                          .elementAt(index),
                                                    ));
                                                  },
                                                  itemCount: controller
                                                      .wnbagamedata.length,
                                                )
                                              : Center(
                                                  heightFactor: 3,
                                                  child: Text(
                                                    "No Data Available",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )
                                          : const Center(
                                              child: CupertinoActivityIndicator(
                                                  color: Colors.grey),
                                            );
                                    })
                                  : _splashController.currentGame.value == "MLB"
                                      ? GetBuilder<EventController>(
                                          builder: (controller) {
                                          return controller
                                                  .mlbEventloading.value
                                              ? controller
                                                      .mlbgamedata.isNotEmpty
                                                  ? ListView.separated(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return const SizedBox(
                                                          height: 5,
                                                        );
                                                      },
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return InkWell(
                                                            child: ScoreItem(
                                                          item: controller
                                                              .mlbgamedata
                                                              .elementAt(index),
                                                        ));
                                                      },
                                                      itemCount: controller
                                                          .mlbgamedata.length,
                                                    )
                                                  : Center(
                                                      heightFactor: 3,
                                                      child: Text(
                                                        "No Data Available",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    )
                                              : const Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                                          color: Colors.grey),
                                                );
                                        })
                                      : _splashController.currentGame.value ==
                                              "NFL"
                                          ? GetBuilder<EventController>(
                                              builder: (controller) {
                                              return controller
                                                      .nflEventloading.value
                                                  ? controller.nflgamedata
                                                          .isNotEmpty
                                                      ? ListView.separated(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          primary: false,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                              height: 5,
                                                            );
                                                          },
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return InkWell(
                                                                // onTap: () {
                                                                //   Get.toNamed(
                                                                //       scoredetailPage);
                                                                // },
                                                                child:
                                                                    ScoreItem(
                                                              item: controller
                                                                  .nflgamedata
                                                                  .elementAt(
                                                                      index),
                                                            ));
                                                          },
                                                          itemCount: controller
                                                              .nflgamedata
                                                              .length,
                                                        )
                                                      : Center(
                                                          heightFactor: 3,
                                                          child: Text(
                                                            "No Data Available",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: brightness ==
                                                                        Brightness
                                                                            .dark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                          ),
                                                        )
                                                  : const Center(
                                                      child:
                                                          CupertinoActivityIndicator(
                                                              color:
                                                                  Colors.grey),
                                                    );
                                            })
                                          : _splashController
                                                      .currentGame.value ==
                                                  "NCAAF"
                                              ? GetBuilder<EventController>(
                                                  builder: (controller) {
                                                  return controller
                                                          .ncaafEventloading
                                                          .value
                                                      ? controller.ncaafgamedata
                                                              .isNotEmpty
                                                          ? ListView.separated(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              shrinkWrap: true,
                                                              primary: false,
                                                              separatorBuilder:
                                                                  (context,
                                                                      index) {
                                                                return const SizedBox(
                                                                  height: 5,
                                                                );
                                                              },
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return InkWell(
                                                                    child:
                                                                        ScoreItem(
                                                                  item: controller
                                                                      .ncaafgamedata
                                                                      .elementAt(
                                                                          index),
                                                                ));
                                                              },
                                                              itemCount: controller
                                                                  .ncaafgamedata
                                                                  .length,
                                                            )
                                                          : Center(
                                                              heightFactor: 3,
                                                              child: Text(
                                                                "No Data Available",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: brightness ==
                                                                            Brightness
                                                                                .dark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                            )
                                                      : const Center(
                                                          child:
                                                              CupertinoActivityIndicator(
                                                                  color: Colors
                                                                      .grey),
                                                        );
                                                })
                                              : GetBuilder<EventController>(
                                                  builder: (controller) {
                                                  return controller
                                                          .nhlEventloading.value
                                                      ? controller.nhlgamedata
                                                              .isNotEmpty
                                                          ? ListView.separated(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              shrinkWrap: true,
                                                              primary: false,
                                                              separatorBuilder:
                                                                  (context,
                                                                      index) {
                                                                return const SizedBox(
                                                                  height: 5,
                                                                );
                                                              },
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return ScoreItem(
                                                                  item: controller
                                                                      .nhlgamedata
                                                                      .elementAt(
                                                                          index),
                                                                );
                                                              },
                                                              itemCount:
                                                                  controller
                                                                      .nhlgamedata
                                                                      .length,
                                                            )
                                                          : Center(
                                                              heightFactor: 3,
                                                              child: Text(
                                                                "No Data Available",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: brightness ==
                                                                            Brightness
                                                                                .dark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                            )
                                                      : const Center(
                                                          child:
                                                              CupertinoActivityIndicator(
                                                                  color: Colors
                                                                      .grey),
                                                        );
                                                })
                    ],
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
          builder: (controller) => Obx(() => BottomNavigationBar(
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: ProjectColors.primaryColor,
                selectedItemColor: ProjectColors.bottomnavselectedcolor,
                unselectedItemColor: ProjectColors.grey,
                selectedFontSize: 8,
                unselectedFontSize: 8,
                currentIndex: _splashController.currentBottom.value,
                onTap: (value) {
                  setState(() {
                    _splashController.currentBottom.value = value;
                    _splashController.update();
                    if (kDebugMode) {
                      print(_splashController.currentBottom.value.toString());
                    }
                    Get.offAllNamed(landingpage);
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    activeIcon: SvgPicture.asset(
                      "assets/images/homeactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/homeicon.svg",
                      height: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "News",
                    activeIcon: SvgPicture.asset(
                      "assets/images/newsactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/newsicon.svg",
                      height: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Pick/Odds",
                    activeIcon: SvgPicture.asset(
                      "assets/images/pickactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/pickicon.svg",
                      height: 20,
                    ),
                  ),
                ],
              ))),
    );
  }
}

class GameWeek {
  const GameWeek(this.date, this.week, this.isselected);
  final String week;
  final String date;
  final bool isselected;
}
