import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:get/get.dart';
import 'package:planet_scape/rive_animations/rive_standard_animation.dart';
import 'package:planet_scape/stages/stage_one.dart';
import 'package:rive/rive.dart';

class Background extends PositionComponent {
  @override
  Future<void>? onLoad() async{
    priority=1;
    position=Vector2(0,-20);
    size=Vector2(250,250);
    anchor=Anchor.centerLeft;

    final skillsArtboard = await loadArtboard(RiveFile.asset('assets/images/rive/background.riv'));
    final rive= RiveStandarAnimation(
        skillsArtboard,
        size
    );
    add(rive);
    return super.onLoad();
  }
}