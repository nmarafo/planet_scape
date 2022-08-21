import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/controller.dart';

class TextFinish extends TextBoxComponent {

  final Controller c = Get.find();
  final Vector2 parentCanvas;

  TextFinish(
      String text, this.parentCanvas,{
        super.position,
        super.align,
        super.size,
        double? timePerChar,
        double? margins,
      }) : super(
    text: text,
    boxConfig: TextBoxConfig(
        maxWidth: parentCanvas.x,
        timePerChar: 0.05,
        growingBox: true,
        margins: EdgeInsets.all(margins ?? 10)
    ),
  );

  @override
  Future<void> onLoad() {
    priority=100;

    positionType=PositionType.viewport;

    final _regularTextStyle = TextStyle(fontSize: parentCanvas.y/10, color: BasicPalette.black.color);
    final _regular = TextPaint(style: _regularTextStyle);
    final _box = _regular.copyWith(
          (style) => style.copyWith(
        color: Colors.black,
        fontFamily: 'monospace',
        letterSpacing: 2.0,
        shadows: const [
          //Shadow(color: Colors.black, offset: Offset(-4, -4), blurRadius: 1),
        ],
      ),
    );
    super.textRenderer=_box;
    anchor=Anchor.center;
    //position=Vector2(parentCanvas.x/2,parentCanvas.y/2);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(rect, Paint()..color = const Color.fromRGBO(0, 0, 0, 0));
    super.render(canvas);
  }

}