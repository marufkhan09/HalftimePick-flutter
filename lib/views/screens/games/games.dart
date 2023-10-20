import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/models/calendermodel.dart';
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

class _SpecificGamesPageState extends State<SpecificGamesPage> {
  String today = "";
  final SplashController _splashController = Get.find<SplashController>();
  final EventController eventController = Get.put(EventController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> gameKey = GlobalKey();

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
    if (_splashController.currentGame.value.isEmpty &&
        _splashController.currentBottom.value == 3) {
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

  @override
  void initState() {
    calender();
    currentGame();
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
        actions: [],
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
                    print(_splashController.currentBottom.value.toString());
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
