import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/dimensions.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  final bool search;
  final bool logo;

//  final int index;

  const CustomAppBar({
    Key? key,
    required this.scaffoldkey,
    required this.search,
    required this.logo,

    //   required this.index
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(56.0);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  final SplashController splashController = Get.find<SplashController>();
  String gamename = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ProjectColors.secondaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.white),
          title: Row(
            mainAxisAlignment: controller.currentBottom.value == 1 ||
                    controller.currentBottom.value == 2
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              controller.currentBottom.value == 1 ||
                      controller.currentBottom.value == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset("assets/images/logo.svg"),
                    )
                  : const SizedBox.shrink(),
              !widget.logo
                  ? Obx(
                      () => Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: controller.currentBottom.value == 0
                            ? const Text("ALL SPORTS")
                            : controller.currentBottom.value == 3
                                ? controller.currentGame.value.isNotEmpty
                                    ? Text(
                                        controller.currentGame.value.toString())
                                    : const Text("NHL")
                                : const Text(""),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          centerTitle: false,
          titleSpacing: 0.0,
          actions: [
            // controller.currentBottom.value == 1 ||
            //         controller.currentBottom.value == 2
            //     ? Container(
            //         margin: const EdgeInsets.only(right: 10),
            //         child: InkWell(
            //           child: SvgPicture.asset(
            //             "assets/images/search.svg",
            //           ),
            //           onTap: () {
            //             //  Get.toNamed(friendlysearchPage);
            //           },
            //         ),
            //       )
            //     : const SizedBox.shrink(),
            // const SizedBox(
            //   width: 10,
            // ),
          ],
        ),
      );
    });
  }
}
