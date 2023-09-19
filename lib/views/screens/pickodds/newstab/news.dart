import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
//dont remove
import 'package:collection/collection.dart';
import 'package:halftimepick/controllers/news_controller.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/views/screens/news/newspage.dart';
import 'package:halftimepick/views/screens/news/newstile/nbaImageTile.dart';
import 'package:halftimepick/views/screens/news/newstile/nhlImageTile.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  final NewsController newsController = Get.put(NewsController());
  List<String> images = [
    "5.png", //NCAAF
    "7.png", //NFL
    "mlb.png", // MLB
    "1.png", //NBA

    "4.png", //NHL

    "6.png", //NCAAB
    "2.png", //WNBA
  ];
  List<Games> gamename = [
    Games(name: "NCAA Football", isselected: false),
    Games(
      name: "NFL",
      isselected: false,
    ),
    Games(name: "MLB", isselected: false),
    Games(name: "NBA", isselected: false),
    Games(name: "NHL", isselected: false),
    Games(name: "NCAAB", isselected: false),
    Games(name: "WNBA", isselected: false),
  ];

  static const tiles = [
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
    GridTile(4, 2),
    GridTile(2, 2),
    GridTile(2, 2),
  ];
  List<GridTile> newslist = [];
  int temp = 0;

  @override
  void initState() {
    gamename.elementAt(3).isselected = true;
    newsController.getNBANews().then((value) {
      // print(value.news!.length.toString());
      if (value.length > 0 && tiles.length > value.length) {
        for (int i = 0; i < value.length; i++) {
          newslist.add(tiles.elementAt(i));
        }
        print("LL:" + newslist.length.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            height: 88,
            color: Colors.black,
          ),
          // Container(
          //   height: 30,
          //   color: ProjectColors.secondaryColor,
          // ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
            ),
            height: 88,
            child: ListView.separated(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 15,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      gamename.forEach((element) {
                        element.isselected = false;
                      });
                      gamename.elementAt(index).isselected = true;
                      print(gamename.elementAt(index).name);
                      if (gamename.elementAt(index).name == "NBA") {
                        newsController.getNBANews().then((value) {
                          newslist.clear();
                          if (value.length > 0 && tiles.length > value.length) {
                            for (int i = 0; i < value.length; i++) {
                              newslist.add(tiles.elementAt(i));
                            }
                            print("NBA:" + newslist.length.toString());
                          }
                        });
                      } else if (gamename.elementAt(index).name == "NHL") {
                        newsController.getNHLNews().then((value) {
                          // print(value.news!.length.toString());
                          newslist.clear();
                          if (value.length > 0 && tiles.length > value.length) {
                            for (int i = 0; i < value.length; i++) {
                              newslist.add(tiles.elementAt(i));
                            }
                            print("NHL:" + newslist.length.toString());
                          }
                        });
                      } else {}
                    });
                  },
                  child: SizedBox(
                    height: 40,
                    width: 50,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/${images.elementAt(index)}",
                          width: 30,
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            gamename.elementAt(index).name!,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: gamename.elementAt(index).isselected
                                ? const TextStyle(
                                    // fontSize: 10,
                                    color: ProjectColors.secondaryTextColor)
                                : const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ]),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        gamename.elementAt(3).isselected
            ? GetBuilder<NewsController>(builder: (controller) {
                return controller.nbanewsAvailable.isTrue
                    ? controller.nbanewslist.isNotEmpty
                        ? StaggeredGrid.count(
                            crossAxisCount: 4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            children: [
                              ...newslist.mapIndexed((index, tile) {
                                return StaggeredGridTile.count(
                                  crossAxisCellCount: tile.crossAxisCount,
                                  mainAxisCellCount: tile.mainAxisCount,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(newsdetailwebview,
                                          arguments: [
                                            controller.nbanewslist
                                                .elementAt(index)
                                                .title,
                                            controller.nbanewslist
                                                .elementAt(index)
                                                .url
                                          ]);
                                    },
                                    child: NbaImageTile(
                                      index: index,
                                      width: tile.crossAxisCount * 100,
                                      height: tile.mainAxisCount * 100,
                                      list: controller.nbanewslist,
                                      ratio: tile.crossAxisCount == 4
                                          ? "full"
                                          : "",
                                    ),
                                  ),
                                );
                              }),
                            ],
                          )
                        : const SizedBox.shrink()
                    : Center(
                        heightFactor: 4,
                        child: CupertinoActivityIndicator(
                          color: Colors.grey.shade200,
                        ));
              })
            : gamename.elementAt(4).isselected
                ? GetBuilder<NewsController>(builder: (controller) {
                    return controller.nhlnewsAvailable.isTrue
                        ? controller.nhlnewslist.isNotEmpty
                            ? StaggeredGrid.count(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                children: [
                                  ...newslist.mapIndexed((index, tile) {
                                    return StaggeredGridTile.count(
                                      crossAxisCellCount: tile.crossAxisCount,
                                      mainAxisCellCount: tile.mainAxisCount,
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(newsdetailwebview,
                                              arguments: [
                                                controller.nhlnewslist
                                                    .elementAt(index)
                                                    .title,
                                                controller.nhlnewslist
                                                    .elementAt(index)
                                                    .url
                                              ]);
                                        },
                                        child: NhlImageTile(
                                          index: index,
                                          width: tile.crossAxisCount * 100,
                                          height: tile.mainAxisCount * 100,
                                          list: controller.nhlnewslist,
                                          ratio: tile.crossAxisCount == 4
                                              ? "full"
                                              : "",
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              )
                            : const SizedBox.shrink()
                        : Center(
                            heightFactor: 4,
                            child: CupertinoActivityIndicator(
                              color: Colors.grey.shade200,
                            ));
                  })
                : const Center(
                    heightFactor: 4,
                    child: Text(
                      "NOT FOUND",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
      ],
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
