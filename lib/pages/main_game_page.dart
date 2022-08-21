
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../stages/stage_one.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  State<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  late final StageOne _game;

  @override
  void initState() {
    super.initState();
    _game = StageOne();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child:  GameWidget(
                game: _game,
                loadingBuilder: (context) => Center(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 50,),
                        Expanded(child: Container()),
                        const SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('loading...'),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tight(const Size(100,100)),
                            child: Container(),
                          ),
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  ),
                ),
                //Work in progress error handling
                errorBuilder: (context, ex) {
                  //Print the error in th dev console
                  debugPrint(ex.toString());
                  return const Center(
                    child: Text('Sorry, something went wrong. Reload me'),
                  );
                },
              )
          ),
        ],
      ),
    );
  }
}