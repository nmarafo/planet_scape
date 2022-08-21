import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' hide window;

import '../utils/controller.dart';
import 'main_game_page.dart';

class PreviousPageMobile extends StatefulWidget {
  const PreviousPageMobile({Key? key}) : super(key: key);

  @override
  State<PreviousPageMobile> createState() => _PreviousPageMobileState();
}

class _PreviousPageMobileState extends State<PreviousPageMobile> with WidgetsBindingObserver{
  final Controller c = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  double width = 0.0;
  double height = 0.0;

  bool isChangeMetrics=false;

  @override void didChangeMetrics() {
    setState(() {
      isChangeMetrics=true;
      width = window.physicalSize.width;
      height = window.physicalSize.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!isChangeMetrics){
      width=MediaQuery.of(context).size.width;
      height=MediaQuery.of(context).size.height;
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child:  Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('tablet_orientation'.tr,style: const TextStyle(color: Colors.black),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: FloatingActionButton(
                        heroTag: 'panoramic',
                        child: const Icon(Icons.play_arrow),
                        onPressed: (){
                          if(width>height){
                            Get.to(const MainGamePage());
                          }else{
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('alert_dialog_tittle'.tr),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('alert_dialog_message1'.tr),
                                        Text('alert_dialog_message2'.tr),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('alert_dialog_message3'.tr),
                                      onPressed: () {
                                        document.exitFullscreen();
                                        Get.offNamed('/');
                                      },
                                    ),
                                    TextButton(
                                      child: Text('alert_dialog_message4'.tr),
                                      onPressed: () {
                                        Get.to(const MainGamePage());
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(50),
                      child: Row(
                        children: [
                          FloatingActionButton(
                            heroTag: 'back',
                            child: const Icon(Icons.arrow_back),
                            onPressed: (){
                              Get.offNamed('/');
                            },
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                  ],
                )
                ,
              )
          ),
        ],
      ),
    );
  }
}