import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halftimepick/utils/colors.dart';
import 'package:halftimepick/utils/routes.dart';
import 'package:halftimepick/views/screens/home/homepage.dart';
import 'package:halftimepick/views/screens/landing/landingpage.dart';
import 'package:halftimepick/views/screens/news/newspage.dart';
import 'package:halftimepick/views/screens/news/newstile/newsdetailweb.dart';
import 'package:halftimepick/views/screens/pickodds/pickoddspage.dart';
import 'package:halftimepick/views/screens/scores/scorespage.dart';
import 'package:halftimepick/views/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('my')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: true,
        useOnlyLangCode: true,
        child: const MyApp()));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    ambiguate(WidgetsBinding.instance)!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    super.dispose();
  }

  late AppLifecycleState notification;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() async {
      notification = state;
    });
    if (kDebugMode) {
      print("state::${state.name}");
    }
    if (state == AppLifecycleState.inactive) {
      if (kDebugMode) {
        print("state::${state.name}");
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(
      brightness: brightness,
    );

    return brightness == Brightness.light

        //light mode
        ? baseTheme.copyWith(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme).copyWith(
              headlineMedium:
                  const TextStyle(fontSize: 16.0, color: Colors.black),
              headlineLarge:
                  const TextStyle(fontSize: 20.0, color: Colors.black),
              titleLarge: const TextStyle(
                  fontSize: 24.0, color: ProjectColors.textBlack),
              titleMedium: const TextStyle(
                  fontSize: 16.0,
                  color: ProjectColors.textBlack,
                  overflow: TextOverflow.ellipsis),
              titleSmall: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: ProjectColors.textBlack),
              bodySmall: const TextStyle(
                  fontSize: 12.0,
                  color: ProjectColors.textBlack,
                  fontWeight: FontWeight.normal),
            ),
          )
        //dark mode
        : baseTheme.copyWith(
            scaffoldBackgroundColor: Colors.black,
            textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme).copyWith(
              headlineMedium:
                  const TextStyle(fontSize: 16.0, color: Colors.white),
              headlineLarge:
                  const TextStyle(fontSize: 20.0, color: Colors.white),
              titleLarge: const TextStyle(fontSize: 24.0, color: Colors.white),
              titleMedium: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis),
              titleSmall: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              bodySmall: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    print(brightness.toString());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(brightness),
      themeMode: ThemeMode.system,
      home: const Splash(),
      navigatorKey: navigatorKey,
      getPages: [
        GetPage(
          name: homePage,
          page: () => const HomePage(),
        ),
        GetPage(
          name: newsPage,
          page: () => const NewsPage(),
        ),
        GetPage(
          name: scoresPage,
          page: () => const ScoresPage(),
        ),
        GetPage(
          name: pickOddsPage,
          page: () => const PickOddsPage(),
        ),
        GetPage(
          name: landingpage,
          page: () => const LandingPage(),
        ),
        GetPage(name: newsdetailwebview, page: () => const NewsDetailWebView()),
      ],
    );
  }
}
