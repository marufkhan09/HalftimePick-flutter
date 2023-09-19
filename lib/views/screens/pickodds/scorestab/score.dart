import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/views/screens/scores/scoreItem.dart';

class ScoreTab extends StatefulWidget {
  const ScoreTab({super.key});

  @override
  State<ScoreTab> createState() => _ScoreTabState();
}

class _ScoreTabState extends State<ScoreTab> {
  String today = "";
  List<String> currentMonth = [];
  List<String> apicurrentMonth = [];
  List<bool> selectionList = [];
  final SplashController _splashController = Get.find<SplashController>();
  final EventController eventController = Get.put(EventController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Obx(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                        child: ScoreItem(
                                      item: controller.ncaabgamedata
                                          .elementAt(index),
                                    ));
                                  },
                                  itemCount: controller.ncaabgamedata.length,
                                )
                              : Center(
                                  heightFactor: 3,
                                  child: Text(
                                    "No Data Available",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: brightness == Brightness.dark
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
                      ? GetBuilder<EventController>(builder: (controller) {
                          return controller.nbaEventloading.value
                              ? controller.nbagamedata.isNotEmpty
                                  ? ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      primary: false,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 5,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                            child: ScoreItem(
                                          item: controller.nbagamedata
                                              .elementAt(index),
                                        ));
                                      },
                                      itemCount: controller.nbagamedata.length,
                                    )
                                  : Center(
                                      heightFactor: 3,
                                      child: Text(
                                        "No Data Available",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: brightness == Brightness.dark
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
                          ? GetBuilder<EventController>(builder: (controller) {
                              return controller.wnbaEventloading.value
                                  ? controller.wnbagamedata.isNotEmpty
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
                                              item: controller.wnbagamedata
                                                  .elementAt(index),
                                            ));
                                          },
                                          itemCount:
                                              controller.wnbagamedata.length,
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
                                  return controller.mlbEventloading.value
                                      ? controller.mlbgamedata.isNotEmpty
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
                                                  item: controller.mlbgamedata
                                                      .elementAt(index),
                                                ));
                                              },
                                              itemCount:
                                                  controller.mlbgamedata.length,
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
                              : _splashController.currentGame.value == "NFL"
                                  ? GetBuilder<EventController>(
                                      builder: (controller) {
                                      return controller.nflEventloading.value
                                          ? controller.nflgamedata.isNotEmpty
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
                                                        // onTap: () {
                                                        //   Get.toNamed(
                                                        //       scoredetailPage);
                                                        // },
                                                        child: ScoreItem(
                                                      item: controller
                                                          .nflgamedata
                                                          .elementAt(index),
                                                    ));
                                                  },
                                                  itemCount: controller
                                                      .nflgamedata.length,
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
                                  : _splashController.currentGame.value ==
                                          "NCAAF"
                                      ? GetBuilder<EventController>(
                                          builder: (controller) {
                                          return controller
                                                  .ncaafEventloading.value
                                              ? controller
                                                      .ncaafgamedata.isNotEmpty
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
                                                              .ncaafgamedata
                                                              .elementAt(index),
                                                        ));
                                                      },
                                                      itemCount: controller
                                                          .ncaafgamedata.length,
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
                                      : GetBuilder<EventController>(
                                          builder: (controller) {
                                          return controller
                                                  .nhlEventloading.value
                                              ? controller
                                                      .nhlgamedata.isNotEmpty
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
                                                        return ScoreItem(
                                                          item: controller
                                                              .nhlgamedata
                                                              .elementAt(index),
                                                        );
                                                      },
                                                      itemCount: controller
                                                          .nhlgamedata.length,
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
            ],
          )),
    );
  }
}

class GameWeek {
  const GameWeek(this.date, this.week, this.isselected);
  final String week;
  final String date;
  final bool isselected;
}
