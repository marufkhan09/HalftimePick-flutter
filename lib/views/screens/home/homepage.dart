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
    "7.png",
    "2.png",
    "1.png",
    "mlb.png",
    "4.png",
    "5.png",
    "6.png"
  ];

  @override
  void initState() {
    homeController.getAllGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Column(
      children: [
        GetBuilder<HomeController>(builder: (controller) {
          return controller.gameAvailable.isTrue
              ? controller.sports.isNotEmpty
                  ? ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.sports.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            splashController.selectedGameIndex.value = index;
                            splashController.currentBottom.value = 1;
                            splashController.update();
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
                                      controller.sports
                                          .elementAt(index)
                                          .sportName!,
                                      style:
                                          const TextStyle(color: Colors.white),
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
                            : const TextStyle(
                                color: Colors.white, fontSize: 16),
                      ),
                    )
              : const Center(
                  heightFactor: 4,
                  child: CupertinoActivityIndicator(color: Colors.grey),
                );
        })
      ],
    );
  }
}
