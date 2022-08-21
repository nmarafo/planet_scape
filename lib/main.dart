import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planet_scape/pages/intro_page.dart';
import 'package:planet_scape/pages/main_game_page.dart';
import 'package:planet_scape/pages/previous_page_mobile.dart';
import 'package:planet_scape/utils/controller.dart';
import 'package:planet_scape/utils/messages/messages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: Messages(),
      fallbackLocale: const Locale('en', 'UK'),
      title: 'Planet Scape',
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/main_game_page': (context) => const MainGamePage(),
        '/previous_page_mobile': (context) => const PreviousPageMobile(),
      },
    );
  }
}