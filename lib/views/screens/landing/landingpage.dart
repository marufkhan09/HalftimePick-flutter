import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/home_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/views/custom_widgets/custom_appbar.dart';
import 'package:halftimepick/views/screens/home/homepage.dart';
import 'package:halftimepick/views/screens/news/newspage.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddspage.dart';
import 'package:halftimepick/views/screens/scores/scorespage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final SplashController _splashController = Get.find<SplashController>();
  final HomeController _homeController = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _landingKey = GlobalKey();

  bool dialogOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const NewsPage(),
    const ScoresPage(),
    const PickOddsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black,
      appBar: CustomAppBar(
        scaffoldkey: _landingKey,
        search: false,
        logo: false,
      ),
      body: GetBuilder<HomeController>(builder: ((controller) {
        return SingleChildScrollView(
            controller: _homeController.scontroller.value,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: GetBuilder<HomeController>(builder: (controller) {
              return Obx(() {
                return _widgetOptions
                    .elementAt(_splashController.currentBottom.value);
              });
            }));
      })),
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
                    // if (_splashController.currentBottom.value == 3) {
                    //    _splashController.currentGame.value = "NHL";
                    // }
                    _splashController.update();
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
                    label: "Scores",
                    activeIcon: SvgPicture.asset(
                      "assets/images/scoresactive.svg",
                      height: 20,
                    ),
                    icon: SvgPicture.asset(
                      "assets/images/scoreicon.svg",
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
