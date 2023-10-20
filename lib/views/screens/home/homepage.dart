import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  final SplashController splashController = Get.find<SplashController>();
  List<String> images = [
    "5.png", //ncaaf
    "7.png", //nfl
    "mlb.png", //mlb
    "1.png", //nba
    "6.png", //ncaab
    "4.png", //nhl
    "2.png", //wnba
  ];

  @override
  void initState() {
    //  homeController.getAllGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Column(
      children: [
        GetBuilder<HomeController>(builder: (controller) {
          return controller.gamename.isNotEmpty
              ? ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controller.gamename.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        /*     splashController.selectedGameIndex.value = index;
                            splashController.currentBottom.value = 1;
                            splashController.update(); */

                        if (controller.gamename.elementAt(index).sportName! ==
                            "NCAA Football") {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "NCAAF";
                          splashController.update();
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NFL") {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "NFL";
                          splashController.update();
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "MLB") {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "MLB";
                          splashController.update();
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NBA") {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "NBA";
                          splashController.update();
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NCAA Men's Basketball") {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "NCAAB";
                          splashController.update();
                        } else if (controller.gamename
                                .elementAt(index)
                                .sportName! ==
                            "NHL") {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "NHL";
                          splashController.update();
                        } else {
                          splashController.currentBottom.value = 2;
                          splashController.currentGame.value = "WNBA";
                          splashController.update();
                        }
                      },
                      child: Container(
                        color: ProjectColors.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: Image.asset(
                                    "assets/images/${images.elementAt(index)}",
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                Text(
                                  controller.gamename
                                      .elementAt(index)
                                      .sportName!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  heightFactor: 4,
                  child: Text(
                    "NO GAME AVAILABLE",
                    style: brightness == Brightness.light
                        ? const TextStyle(color: Colors.black, fontSize: 16)
                        : const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
        })
      ],
    );
  }
}
