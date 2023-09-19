import 'package:flutter/material.dart';
import 'package:halftimepick/utils/colors.dart';

class ScoreItem extends StatefulWidget {
  final dynamic item;
  const ScoreItem({super.key, required this.item});

  @override
  State<ScoreItem> createState() => _ScoreItemState();
}

class _ScoreItemState extends State<ScoreItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: ProjectColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 12,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ProjectColors.secondaryTextColor,
                          ),
                          child: const Text(
                            //before
                            // "H",
                            "A",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            //before
                            //  widget.item.teamsNormalized!.elementAt(1).name!,
                            widget.item.teamsNormalized!.first.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ProjectColors.secondaryTextColor,
                          ),
                          child: const Text(
                            //before
                            //"A",
                            "H",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            //before
                            //widget.item.teamsNormalized!.elementAt(0).name!
                            widget.item.teamsNormalized!.elementAt(1).name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      height: 20,
                      width: 40,
                      child: const Text(
                        "Odds",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          child: widget.item.lines!.isNotEmpty
                              ? Text(
                                  widget
                                      .item.lines!.first.spread!.pointSpreadHome
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              : const Text("-"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          child: widget.item.lines!.isNotEmpty
                              ? Text(
                                  //before
                                  //    widget.item.lines!.first.spread!.pointSpreadAway
                                  //     .toString(),
                                  "T:${widget.item.lines!.first.total!.totalOver.toString()}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              : const Text("-"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      height: 20,
                      width: 40,
                      child: const Text(
                        "Scores",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          child: Text(
                            //before
                            // widget.item.lines!.first.spread!.pointSpreadHome
                            //     .toString(),
                            widget.item.score!.scoreAway!.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 16,
                          child: Text(
                            widget.item.score!.scoreHome!.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.item.score!.eventStatusDetail!,
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.item.score!.broadcast!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        widget.item.message!.isNotEmpty
            ? Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: ProjectColors.primaryColor,
                child: Text(
                  widget.item.message!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
