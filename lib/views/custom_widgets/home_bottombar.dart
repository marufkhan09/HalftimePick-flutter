import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/utils/colors.dart';
import '../../utils/routes.dart';
import '../../utils/shared_pref.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  _HomeBottomBarrState createState() => _HomeBottomBarrState();
}

class _HomeBottomBarrState extends State<HomeBottomBar> {
  final SharedPref _sharedPref = SharedPref();
  int currentBottom = 0;
  String token = "";

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<String> getToken() async {
    token = await _sharedPref.readString("bearerToken") ?? "";
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: ProjectColors.primaryColor,
      unselectedItemColor: ProjectColors.hometext,
      selectedFontSize: 8,
      unselectedFontSize: 8,
      currentIndex: currentBottom,
      onTap: (value) {
        // Respond to item press.
        currentBottom = value;
        print("bottom $value");
        setState(() {
          if (currentBottom == 0) {
            Get.offNamed(homePage);
          } else if (currentBottom == 1) {
            Get.toNamed(mycourselistpage);
          } else if (currentBottom == 2) {
            if (token.isNotEmpty) {
              Get.toNamed(notificationlistpage);
            } else {
              Get.toNamed(loginPage, arguments: ["", ""]);
            }
          } else if (currentBottom == 3) {
            if (token.isNotEmpty) {
              Get.toNamed(accountPage);
            } else {
              Get.toNamed(loginPage, arguments: ["", ""]);
            }
          }
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: "News",
          icon: Icon(Icons.menu_book_sharp),
        ),
        BottomNavigationBarItem(
          label: "Scores",
          icon: Icon(Icons.notifications_none),
        ),
        BottomNavigationBarItem(
          label: "Pick/Odds",
          icon: Icon(Icons.person_outline),
        ),
      ],
    ));
  }
}
