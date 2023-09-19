import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:halftimepick/models/news_nhl/news.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const _defaultColor = Color(0xFF34568B);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.topPadding = 0,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: child,
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class NhlImageTile extends StatefulWidget {
  const NhlImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
    required this.list,
    required this.ratio,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;
  final RxList<nhlLNewsList> list;
  final String ratio;

  @override
  State<NhlImageTile> createState() => _NhlImageTileState();
}

class _NhlImageTileState extends State<NhlImageTile> {
  String returnDate() {
    initializeDateFormatting();
    DateTime day =
        DateTime.parse(widget.list.elementAt(widget.index).publishDate!);
    var outputFormat = DateFormat('dd MMMM, yyyy');
    var outputDate = outputFormat.format(day);
    print(outputDate);
    return outputDate;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite, height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      NetworkImage(widget.list.elementAt(widget.index).image!)
                  // image: Image.asset('assets/overlay.png')
                  //     .image // <--- .image added here
                  )),
          // child: Image.network(
          //   list.elementAt(index).image!,
          //   width: width.toDouble(),
          //   height: height.toDouble(),
          //   fit: BoxFit.cover,
          // ),
          child: SvgPicture.asset(
            'assets/images/overlay.svg',
            width: widget.width.toDouble(),
            height: widget.height.toDouble(),
            fit: BoxFit.fill,
          ),
        ),
        widget.ratio == "full"
            ? Positioned(
                left: 5,
                bottom: 50,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.list.elementAt(widget.index).title.toString(),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            : Positioned(
                left: 5,
                bottom: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  width: MediaQuery.of(context).size.width * 0.44,
                  child: Text(
                    widget.list.elementAt(widget.index).title.toString(),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
        Positioned(
          bottom: widget.ratio == "full" ? 10 : 8,
          left: widget.ratio == "full" ? 10 : 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halftimepick . ${returnDate()}",
                  style: widget.ratio == "full"
                      ? TextStyle(fontSize: 8, color: Colors.grey.shade400)
                      : TextStyle(fontSize: 6, color: Colors.grey.shade400),
                )
              ],
            ),
          ),
        ),
        Positioned(
            right: widget.ratio == "full" ? 10 : 4,
            bottom: widget.ratio == "full" ? 15 : 10,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.list
                            .elementAt(widget.index)
                            .url!
                            .isNotEmpty) {
                          Share.share(widget.list.elementAt(widget.index).url!);
                        }
                      },
                      child: widget.ratio == "full"
                          ? SvgPicture.asset(
                              "assets/images/send.svg",
                              height: 20,
                            )
                          : SvgPicture.asset(
                              "assets/images/send.svg",
                              height: 12,
                            ),
                    ),
                    SizedBox(
                      width: widget.ratio == "full" ? 10 : 4,
                    ),
                    widget.ratio == "full"
                        ? InkWell(
                            // onTap: () {
                            //   if (list.elementAt(index).url!.isNotEmpty) {
                            //     Share.share(list.elementAt(index).url!);
                            //   }
                            // },
                            child: SvgPicture.asset(
                              "assets/images/share.svg",
                              height: 20,
                            ),
                          )
                        : InkWell(
                            // onTap: () {
                            //   if (list.elementAt(index).url!.isNotEmpty) {
                            //     Share.share(list.elementAt(index).url!);
                            //   }
                            // },
                            child: SvgPicture.asset(
                              "assets/images/share.svg",
                              height: 12,
                            ),
                          )
                  ],
                )))
      ],
    );
  }
}

class InteractiveTile extends StatefulWidget {
  const InteractiveTile({
    Key? key,
    required this.index,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  _InteractiveTileState createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<InteractiveTile> {
  Color color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == _defaultColor) {
            color = Colors.red;
          } else {
            color = _defaultColor;
          }
        });
      },
      child: Tile(
        index: widget.index,
        extent: widget.extent,
        backgroundColor: color,
        bottomSpace: widget.bottomSpace,
      ),
    );
  }
}
