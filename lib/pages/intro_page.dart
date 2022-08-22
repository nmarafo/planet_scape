import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planet_scape/pages/previous_page_mobile.dart';
import 'package:rive/rive.dart';
import 'package:universal_html/html.dart';

import '../utils/controller.dart';
import 'main_game_page.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  final Controller c = Get.find();

  final List<Widget> aboutBoxChildren = <Widget>[
    const SizedBox(
      height: 20,
    ),
    const Padding(
      padding: EdgeInsets.all(10),
      child: Text('- Images: Norberto Martín Afonso'),
    ),
    const SizedBox(
      height: 20,
    ),
    const Padding(
      padding: EdgeInsets.all(10),
      child: Text('- Music: Norberto Martín Afonso'),
    ),
    const SizedBox(
      height: 20,
    ),
    const Padding(
      padding: EdgeInsets.all(10),
      child: Text('powered by Flame Engine and Rive'),
    ),
  ];

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);
    //_bump = controller.findInput<bool>('Trigger 1') as SMITrigger;
  }

  final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

  void goToGame(){
    if (isWebMobile) {
      document.documentElement?.requestFullscreen();
      Get.to(const PreviousPageMobile());
    }else{
      Get.to(const MainGamePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                AboutListTile(
                  applicationName: 'Planet Scape',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2022 Norberto Martín Afonso',
                  aboutBoxChildren: aboutBoxChildren,
                  child:  const Text('About app'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.white,)),
          Positioned.fill(
              child:GestureDetector(
                onTap: () {
                  goToGame();
                },
                child: RiveAnimation.asset(
                  'assets/images/rive/intro.riv',
                  fit: BoxFit.contain,
                  onInit: _onRiveInit,
                ),
              ),
          ),
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    goToGame();
                  },
                  child: Text(
                      'Planet Scape',
                      style: GoogleFonts.permanentMarker(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 80,
                          color: Colors.black,
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Flexible(child: Container()),
                        IconButton(
                            onPressed: (){
                              showAboutDialog(
                                context: context,
                                applicationName: 'Planet Scape',
                                applicationVersion: '1.0.0',
                                applicationLegalese: '© 2022 Norberto Martín Afonso',
                                children: aboutBoxChildren,
                              );
                            },
                            icon: const Icon(Icons.info_outline,color: Colors.black,)
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                ],
              )
          )
        ],
      ),
    );
  }
}