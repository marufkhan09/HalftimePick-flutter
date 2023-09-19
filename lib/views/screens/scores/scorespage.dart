import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/models/calendermodel.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/shared_pref.dart';
import 'package:halftimepick/views/screens/scores/scoreItem.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScoresPage extends StatefulWidget {
  const ScoresPage({super.key});

  @override
  State<ScoresPage> createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage>
    with SingleTickerProviderStateMixin {
  final globalKey = GlobalKey();
  late TabController tabController;
  //late ScrollController _scrollController;
  late bool fixedScroll;
  List<bool> selectionList = [];
  final EventController eventController = Get.put(EventController());
  final SplashController _splashController = Get.find<SplashController>();
  String today = "";
  final SharedPref sharedPref = SharedPref();
  List<GamesTab> games = [
    GamesTab("NFL", false),
    GamesTab("NBA", false),
    GamesTab("MLB", false),
    GamesTab("NHL", false),
    GamesTab("NCAAF", false),
    GamesTab("NCAAB", false),
    GamesTab("WNBA", false)
  ];

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
    //_scrollController = ScrollController();
    // _scrollController.addListener(scroll);
    tabController = TabController(length: 3, vsync: this);
    calender();
    eventController.getNcaafEvents(date: today);
    eventController.getNflEvents(date: today);
    eventController.getMlbEvents(date: today);
    eventController.getNbaEvents(date: today);
    eventController.getNcaabEvents(date: today);
    eventController.getWnbaEvents(date: today);
    eventController.getNhlEvents(date: today);

    super.initState();
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
                        });
                        games.elementAt(index).isselected = true;
                        if (games.elementAt(index).name == "NFL") {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "NFL";
                          _splashController.update();
                        } else if (games.elementAt(index).name == "NBA") {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "NBA";
                          _splashController.update();
                        } else if (games.elementAt(index).name == "MLB") {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "MLB";
                          _splashController.update();
                        } else if (games.elementAt(index).name == "NHL") {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "NHL";
                          _splashController.update();
                        } else if (games.elementAt(index).name == "NCAAF") {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "NCAAF";
                          _splashController.update();
                        } else if (games.elementAt(index).name == "NCAAB") {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "NCAAB";
                          _splashController.update();
                        } else {
                          _splashController.currentBottom.value = 3;
                          _splashController.currentGame.value = "WNBA";
                          _splashController.update();
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
                    setState(() {
                      var a = currentMonth
                          .indexWhere((element) => element.isselected == true);

                      currentMonth.elementAt(a).isselected = false;
                      currentMonth.elementAt(index).isselected = true;

                      eventController.ncaafEventloading.value = false;
                      eventController.getNcaafEvents(
                          date: currentMonth[index].apiFormattedDate);
                      eventController.nflEventloading.value = false;
                      eventController.getNflEvents(
                          date: currentMonth[index].apiFormattedDate);

                      eventController.mlbEventloading.value = false;
                      eventController.getMlbEvents(
                          date: currentMonth[index].apiFormattedDate);

                      eventController.nbaEventloading.value = false;
                      eventController.getNbaEvents(
                          date: currentMonth[index].apiFormattedDate);

                      eventController.ncaabEventloading.value = false;
                      eventController.getNcaabEvents(
                          date: currentMonth[index].apiFormattedDate);

                      eventController.wnbaEventloading.value = false;
                      eventController.getWnbaEvents(
                          date: currentMonth[index].apiFormattedDate);

                      eventController.nhlEventloading.value = false;
                      eventController.getNhlEvents(
                          date: currentMonth[index].apiFormattedDate);
                    });
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
          GetBuilder<EventController>(builder: (controller) {
            return controller.nhlEventloading.value
                ? controller.nhlgamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "NHL",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    _splashController.currentBottom.value = 3;
                                    _splashController.currentGame.value = "NHL";
                                    _splashController.update();
                                  },
                                  child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: const Text(
                                      "Go To NHL",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: ProjectColors
                                              .bottomnavselectedcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  // onTap: () {
                                  //   Get.toNamed(scoredetailPage);
                                  // },
                                  child: ScoreItem(
                                item: controller.nhlgamedata.elementAt(index),
                              ));
                            },
                            itemCount: controller.nhlgamedata.length > 5
                                ? 5
                                : controller.nhlgamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
          GetBuilder<EventController>(builder: (controller) {
            return controller.nbaEventloading.value
                ? controller.nbagamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "NBA",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                GetBuilder<SplashController>(
                                    builder: (controller) {
                                  return Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: () {
                                        controller.currentBottom.value = 3;
                                        controller.currentGame.value = "NBA";

                                        controller.update();
                                      },
                                      child: const Text(
                                        "Go To NBA",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: ProjectColors
                                                .bottomnavselectedcolor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  // onTap: () {
                                  //   Get.toNamed(scoredetailPage);
                                  // },
                                  child: ScoreItem(
                                item: controller.nbagamedata.elementAt(index),
                              ));
                            },
                            itemCount: controller.nbagamedata.length > 5
                                ? 5
                                : controller.nbagamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
          GetBuilder<EventController>(builder: (controller) {
            return controller.wnbaEventloading.value
                ? controller.wnbagamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "WNBA",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height: 20,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: InkWell(
                                    onTap: () {
                                      _splashController.currentBottom.value = 3;
                                      _splashController.currentGame.value =
                                          "WNBA";
                                      _splashController.update();
                                    },
                                    child: const Text(
                                      "Go To WNBA",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: ProjectColors
                                              .bottomnavselectedcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ScoreItem(
                                item: controller.wnbagamedata.elementAt(index),
                              );
                            },
                            itemCount: controller.wnbagamedata.length > 5
                                ? 5
                                : controller.wnbagamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
          GetBuilder<EventController>(builder: (controller) {
            return controller.mlbEventloading.value
                ? controller.mlbgamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "MLB",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    _splashController.currentBottom.value = 3;
                                    _splashController.currentGame.value = "MLB";
                                    _splashController.update();
                                  },
                                  child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: const Text(
                                      "Go To MLB",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: ProjectColors
                                              .bottomnavselectedcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  // onTap: () {
                                  //   Get.toNamed(scoredetailPage);
                                  // },
                                  child: ScoreItem(
                                item: controller.mlbgamedata.elementAt(index),
                              ));
                            },
                            itemCount: controller.mlbgamedata.length > 5
                                ? 5
                                : controller.mlbgamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
          GetBuilder<EventController>(builder: (controller) {
            return controller.nflEventloading.value
                ? controller.nflgamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "NFL",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    _splashController.currentBottom.value = 3;
                                    _splashController.currentGame.value = "NFL";
                                    _splashController.update();
                                  },
                                  child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: const Text(
                                      "Go To NFL",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: ProjectColors
                                              .bottomnavselectedcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  // onTap: () {
                                  //   Get.toNamed(scoredetailPage);
                                  // },
                                  child: ScoreItem(
                                item: controller.nflgamedata.elementAt(index),
                              ));
                            },
                            itemCount: controller.nflgamedata.length > 5
                                ? 5
                                : controller.nflgamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
          GetBuilder<EventController>(builder: (controller) {
            return controller.ncaafEventloading.value
                ? controller.ncaafgamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "NCAAF",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    _splashController.currentBottom.value = 3;
                                    _splashController.currentGame.value =
                                        "NCAAF";
                                    _splashController.update();
                                  },
                                  child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: const Text(
                                      "Go To NCAAF",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: ProjectColors
                                              .bottomnavselectedcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  // onTap: () {
                                  //   Get.toNamed(scoredetailPage);
                                  // },
                                  child: ScoreItem(
                                item: controller.ncaafgamedata.elementAt(index),
                              ));
                            },
                            itemCount: controller.ncaafgamedata.length > 5
                                ? 5
                                : controller.ncaafgamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
          GetBuilder<EventController>(builder: (controller) {
            return controller.ncaabEventloading.value
                ? controller.ncaabgamedata.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: ProjectColors.bottomnavselectedcolor,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "NCAAB",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    _splashController.currentBottom.value = 3;
                                    _splashController.currentGame.value =
                                        "NCAAB";
                                    _splashController.update();
                                  },
                                  child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: const Text(
                                      "Go To NCAAB",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: ProjectColors
                                              .bottomnavselectedcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  // onTap: () {
                                  //   Get.toNamed(scoredetailPage);
                                  // },
                                  child: ScoreItem(
                                item: controller.ncaabgamedata.elementAt(index),
                              ));
                            },
                            itemCount: controller.ncaabgamedata.length > 5
                                ? 5
                                : controller.ncaabgamedata.length,
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
                : const Center(
                    heightFactor: 2,
                    child: CupertinoActivityIndicator(color: Colors.grey),
                  );
          }),
        ],
      ),
    );
  }
}

class DateSelected {
  const DateSelected(this.date, this.isselected);
  final String date;
  final bool isselected;
}

class GamesTab {
  GamesTab(this.name, this.isselected);
  final String name;
  bool isselected = false;
}
