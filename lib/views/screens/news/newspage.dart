import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:halftimepick/controllers/news_controller.dart';
import 'package:halftimepick/controllers/splash_controller.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/views/screens/news/newstile/nbaImageTile.dart';
//dont remove it
import 'package:collection/collection.dart';
import 'package:halftimepick/views/screens/news/newstile/nhlImageTile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController newsController = Get.put(NewsController());
  final SplashController splashController = Get.find<SplashController>();

  static const nbatiles = [
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
  static const nhltiles = [
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
  List<GridTile> newsNbalist = [];
  List<GridTile> newsNhllist = [];
//  int temp = 0;

  @override
  void initState() {
    newsController.getNBANews().then((value) {
      newsNbalist.clear();
      if (value.length > 0 && nbatiles.length > value.length) {
        for (int i = 0; i < value.length; i++) {
          newsNbalist.add(nbatiles.elementAt(i));
        }
        //  print("LL:" + newslist.length.toString());
      }
    });
    newsController.getNHLNews().then((value) {
      // print(value.news!.length.toString());
      newsNhllist.clear();
      if (value.length > 0 && nhltiles.length > value.length) {
        for (int i = 0; i < value.length; i++) {
          newsNhllist.add(nhltiles.elementAt(i));
        }
        //  print("NHL:" + newslist.length.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<NewsController>(builder: (controller) {
          return controller.nbanewsAvailable.isTrue
              ? controller.nbanewslist.isNotEmpty
                  ? StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        ...newsNbalist.mapIndexed((index, tile) {
                          return StaggeredGridTile.count(
                            crossAxisCellCount: tile.crossAxisCount,
                            mainAxisCellCount: tile.mainAxisCount,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(newsdetailwebview, arguments: [
                                  controller.nbanewslist.elementAt(index).title,
                                  controller.nbanewslist.elementAt(index).url
                                ]);
                              },
                              child: NbaImageTile(
                                  index: index,
                                  width: tile.crossAxisCount * 100,
                                  height: tile.mainAxisCount * 100,
                                  list: controller.nbanewslist,
                                  ratio:
                                      tile.crossAxisCount == 4 ? "full" : ""),
                            ),
                          );
                        }),
                      ],
                    )
                  : Center(
                      heightFactor: 4,
                      child: Text(
                        "NO NEWS AVAILABLE",
                        style: brightness == Brightness.light
                            ? const TextStyle(color: Colors.black, fontSize: 16)
                            : const TextStyle(
                                color: Colors.white, fontSize: 16),
                      ),
                    )
              : const Center(
                  heightFactor: 3,
                  child: CupertinoActivityIndicator(
                    color: Colors.grey,
                  ));
        }),
        GetBuilder<NewsController>(builder: (controller) {
          return controller.nhlnewsAvailable.isTrue
              ? controller.nhlnewslist.isNotEmpty
                  ? StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        ...newsNhllist.mapIndexed((index, tile) {
                          return StaggeredGridTile.count(
                            crossAxisCellCount: tile.crossAxisCount,
                            mainAxisCellCount: tile.mainAxisCount,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(newsdetailwebview, arguments: [
                                  controller.nhlnewslist.elementAt(index).title,
                                  controller.nhlnewslist.elementAt(index).url
                                ]);
                              },
                              child: NhlImageTile(
                                  index: index,
                                  width: tile.crossAxisCount * 100,
                                  height: tile.mainAxisCount * 100,
                                  list: controller.nhlnewslist,
                                  ratio:
                                      tile.crossAxisCount == 4 ? "full" : ""),
                            ),
                          );
                        }),
                      ],
                    )
                  : Center(
                      heightFactor: 4,
                      child: Text(
                        "NO NEWS AVAILABLE",
                        style: brightness == Brightness.light
                            ? const TextStyle(color: Colors.black, fontSize: 16)
                            : const TextStyle(
                                color: Colors.white, fontSize: 16),
                      ),
                    )
              : const Center(
                  heightFactor: 3,
                  child: CupertinoActivityIndicator(
                    color: Colors.grey,
                  ));
        })
      ],
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

class Games {
  String? name;
  bool isselected;

  Games({this.name, required this.isselected});

  factory Games.fromJson(Map<String, dynamic> json) =>
      Games(name: json['name'] as String?, isselected: false);

  Map<String, dynamic> toJson() => {
        'name': name,
        'isselected': isselected,
      };
}
