import 'dart:math';

import 'package:flutter/material.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/views/screens/scores/scorespage.dart';

class ChattabItem extends StatefulWidget {
  const ChattabItem({super.key});

  @override
  State<ChattabItem> createState() => _ChattabItemState();
}

class _ChattabItemState extends State<ChattabItem> {
  // List<DateSelected> dates = const [
  //   DateSelected("", false),
  //   DateSelected("", false),
  //   DateSelected("", true),
  //   DateSelected("", false),
  //   DateSelected("", false),
  //   DateSelected("", false),
  //   DateSelected("", false),
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.infinity,
      // height: 100,
      decoration: BoxDecoration(
        color: ProjectColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              height: 30,
              width: 30,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "assets/images/13.png",
                    fit: BoxFit.fill,
                  ))),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Jan 03,12:45 PM",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Emma Liam: ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            fontWeight: FontWeight.w600,
                          )),
                      const TextSpan(
                        text:
                            "It is a long established fact that a reader It is a long established fact that a reader It is a long established fact that a reader It is a long established fact that a reader",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
