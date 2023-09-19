import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/mlbeventitem.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/nbaEventItem.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/ncaabEventItem.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/ncaafEventItem.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/nflpickoddTabItem.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/nhleventitem.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddstab/wnbaeventitem.dart';

class PickTab extends StatefulWidget {
  const PickTab({super.key});

  @override
  State<PickTab> createState() => _PickTabState();
}

class _PickTabState extends State<PickTab> {
  final EventController eventController = Get.put(EventController());
  final SplashController _splashController = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _splashController.currentGame == "NFL"
                ? GetBuilder<EventController>(builder: (controller) {
                    return controller.nflEventloading.isTrue
                        ? controller.nflgamedata.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return NFLPickOddstabItem(
                                    events:
                                        controller.nflgamedata.elementAt(index),
                                  );
                                },
                                itemCount: controller.nflgamedata.length,
                              )
                            : Center(
                                heightFactor: 2,
                                child: Text(
                                  "No Data Available",
                                  style: TextStyle(
                                      color: brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20),
                                ),
                              )
                        : const Center(
                            heightFactor: 4,
                            child: CupertinoActivityIndicator(
                              color: Colors.grey,
                            ),
                          );
                  })
                : _splashController.currentGame == "NCAAF"
                    ? GetBuilder<EventController>(builder: (controller) {
                        return controller.ncaafEventloading.isTrue
                            ? controller.ncaafgamedata.isNotEmpty
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
                                      return NcaafEventItem(
                                        events: controller.ncaafgamedata
                                            .elementAt(index),
                                      );
                                    },
                                    itemCount: controller.ncaafgamedata.length,
                                  )
                                : Center(
                                    heightFactor: 2,
                                    child: Text(
                                      "No Data Available",
                                      style: TextStyle(
                                          color: brightness == Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20),
                                    ),
                                  )
                            : const Center(
                                heightFactor: 4,
                                child: CupertinoActivityIndicator(
                                  color: Colors.grey,
                                ),
                              );
                      })
                    : _splashController.currentGame == "MLB"
                        ? GetBuilder<EventController>(builder: (controller) {
                            return controller.mlbEventloading.isTrue
                                ? controller.mlbgamedata.isNotEmpty
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
                                          return MlbEventItem(
                                            events: controller.mlbgamedata
                                                .elementAt(index),
                                          );
                                        },
                                        itemCount:
                                            controller.mlbgamedata.length,
                                      )
                                    : Center(
                                        heightFactor: 2,
                                        child: Text(
                                          "No Data Available",
                                          style: TextStyle(
                                              color:
                                                  brightness == Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontSize: 20),
                                        ),
                                      )
                                : const Center(
                                    heightFactor: 4,
                                    child: CupertinoActivityIndicator(
                                      color: Colors.grey,
                                    ),
                                  );
                          })
                        : _splashController.currentGame == "NBA"
                            ? GetBuilder<EventController>(
                                builder: (controller) {
                                return controller.nbaEventloading.isTrue
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return NbaEventItem(
                                                events: controller.nbagamedata
                                                    .elementAt(index),
                                              );
                                            },
                                            itemCount:
                                                controller.nbagamedata.length,
                                          )
                                        : Center(
                                            heightFactor: 2,
                                            child: Text(
                                              "No Data Available",
                                              style: TextStyle(
                                                  color: brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 20),
                                            ),
                                          )
                                    : const Center(
                                        heightFactor: 4,
                                        child: CupertinoActivityIndicator(
                                          color: Colors.grey,
                                        ),
                                      );
                              })
                            : _splashController.currentGame == "NCAAB"
                                ? GetBuilder<EventController>(
                                    builder: (controller) {
                                    return controller.ncaabEventloading.isTrue
                                        ? controller.ncaabgamedata.isNotEmpty
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
                                                  return NcaabEventItem(
                                                    events: controller
                                                        .ncaabgamedata
                                                        .elementAt(index),
                                                  );
                                                },
                                                itemCount: controller
                                                    .ncaabgamedata.length,
                                              )
                                            : Center(
                                                heightFactor: 2,
                                                child: Text(
                                                  "No Data Available",
                                                  style: TextStyle(
                                                      color: brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 20),
                                                ),
                                              )
                                        : const Center(
                                            heightFactor: 4,
                                            child: CupertinoActivityIndicator(
                                              color: Colors.grey,
                                            ),
                                          );
                                  })
                                : _splashController.currentGame == "WNBA"
                                    ? GetBuilder<EventController>(
                                        builder: (controller) {
                                        return controller
                                                .wnbaEventloading.isTrue
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
                                                      return WnbaEventItem(
                                                        events: controller
                                                            .wnbagamedata
                                                            .elementAt(index),
                                                      );
                                                    },
                                                    itemCount: controller
                                                        .wnbagamedata.length,
                                                  )
                                                : Center(
                                                    heightFactor: 2,
                                                    child: Text(
                                                      "No Data Available",
                                                      style: TextStyle(
                                                          color: brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  )
                                            : const Center(
                                                heightFactor: 4,
                                                child:
                                                    CupertinoActivityIndicator(
                                                  color: Colors.grey,
                                                ),
                                              );
                                      })
                                    : GetBuilder<EventController>(
                                        builder: (controller) {
                                        return controller.nhlEventloading.isTrue
                                            ? controller.nhlgamedata.isNotEmpty
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
                                                      return NhlEventItem(
                                                          events: controller
                                                              .nhlgamedata
                                                              .elementAt(
                                                                  index));
                                                    },
                                                    itemCount: controller
                                                        .nhlgamedata.length,
                                                  )
                                                : Center(
                                                    heightFactor: 2,
                                                    child: Text(
                                                      "No Data Available",
                                                      style: TextStyle(
                                                          color: brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  )
                                            : const Center(
                                                heightFactor: 4,
                                                child:
                                                    CupertinoActivityIndicator(
                                                  color: Colors.grey,
                                                ),
                                              );
                                      })
          ],
        ));
  }
}

class GameWeek {
  const GameWeek(this.date, this.week, this.isselected);
  final String week;
  final String date;
  final bool isselected;
}
