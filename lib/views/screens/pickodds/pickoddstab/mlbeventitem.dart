import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/events_controller.dart';
import 'package:halftimepick/models/mlb_game/datum.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/launcher.dart';
import 'package:intl/date_symbol_data_local.dart';

class MlbEventItem extends StatefulWidget {
  final MlbGameData events;

  const MlbEventItem({
    super.key,
    required this.events,
  });

  @override
  State<MlbEventItem> createState() => _MlbEventItemState();
}

class _MlbEventItemState extends State<MlbEventItem> {
  String eventPlace(String eventname) {
    var a =
        eventname.substring(0, widget.events.schedule!.eventName!.indexOf('-'));
    return a;
  }

  String returnDate(date) {
    initializeDateFormatting();
    DateTime day = DateTime.parse(date);
    var outputFormat = DateFormat('dd MMM, yyyy');
    var outputDate = outputFormat.format(day);
    return outputDate;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ProjectColors.primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, bottom: 5),
              child: Text(
                eventPlace(widget.events.schedule!.eventName!),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                mainAxisAlignment: widget.events.isPick!
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: widget.events.isPick!
                        ? MediaQuery.of(context).size.width * 0.27
                        : MediaQuery.of(context).size.width * 0.29,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            returnDate(widget.events.eventDate),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ProjectColors.secondaryTextColor,
                                ),
                                child: const Text(
                                  "A",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.events.teamsNormalized!
                                      .elementAt(0)
                                      .name!
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ProjectColors.secondaryTextColor,
                                ),
                                child: const Text(
                                  "H",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.events.teamsNormalized!
                                      .elementAt(1)
                                      .name!
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.events.lines!.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: widget.events.isPick!
                                  ? MediaQuery.of(context).size.width * 0.17
                                  : MediaQuery.of(context).size.width * 0.21,
                              height: 100,
                              child: GetBuilder<EventController>(
                                  builder: (controller) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 15,
                                      ),
                                      child: const Text(
                                        "Money line",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: ProjectColors
                                                  .secondaryTextColor)),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        widget.events.lines!.first.moneyline!
                                            .moneylineAway!
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: ProjectColors
                                                  .secondaryTextColor)),
                                      child: Text(
                                        widget.events.lines!.first.moneyline!
                                            .moneylineHome
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ),
                            Container(
                              width: widget.events.isPick!
                                  ? MediaQuery.of(context).size.width * 0.17
                                  : MediaQuery.of(context).size.width * 0.21,
                              height: 100,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    child: const Text(
                                      "Spread",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: ProjectColors
                                                .secondaryTextColor)),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.events.lines!.first.spread!
                                              .pointSpreadAway
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.events.lines!.first.spread!
                                              .pointSpreadAwayDelta
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: ProjectColors
                                                .secondaryTextColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.events.lines!.first.spread!
                                              .pointSpreadHome
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.events.lines!.first.spread!
                                              .pointSpreadHomeDelta
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: widget.events.isPick!
                                  ? MediaQuery.of(context).size.width * 0.17
                                  : MediaQuery.of(context).size.width * 0.21,
                              height: 100,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 15,
                                    ),
                                    child: const Text(
                                      "Total",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: ProjectColors
                                                .secondaryTextColor)),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.events.lines!.first.total!
                                              .totalOver
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.events.lines!.first.total!
                                              .totalOverDelta
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: ProjectColors
                                                .secondaryTextColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.events.lines!.first.total!
                                              .totalUnder
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          widget.events.lines!.first.total!
                                              .totalOverDelta
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            widget.events.isPick!
                                ? InkWell(
                                    onTap: () {
                                      UrlLauncher.launch(
                                          widget.events.url.toString());
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(left: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white),
                                      height: 30,
                                      child: const Text(
                                        "Pick",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: ProjectColors
                                                .secondaryTextColor),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        )
                      : const Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text(
                            "No Odds Available Currently",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}
