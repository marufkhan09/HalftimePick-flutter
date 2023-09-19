import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailWebView extends StatefulWidget {
  const NewsDetailWebView({super.key});

  @override
  State<NewsDetailWebView> createState() => _NewsDetailWebViewState();
}

class _NewsDetailWebViewState extends State<NewsDetailWebView> {
  final GlobalKey<ScaffoldState> newsdetailkey = GlobalKey();
  late WebViewController controller;
  var pagetitle = Get.arguments[0];
  var url = Get.arguments[1];
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress.toString());
            if (progress == 100) {
              setState(() {
                loaded = true;
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.secondaryColor,
        title: Text(
          pagetitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: loaded
          ? WebViewWidget(controller: controller)
          : const Center(
              heightFactor: 4,
              child: CupertinoActivityIndicator(
                color: Colors.grey,
              ),
            ),
    );
  }
}
