import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:get/get.dart';
import 'package:planet_scape/rive_animations/rive_standard_animation.dart';
import 'package:planet_scape/stages/stage_one.dart';
import 'package:rive/rive.dart';

class HomeButton extends PositionComponent with HasGameRef<StageOne>,Tappable{
  @override
  Future<void>? onLoad() async{
    priority=100;
    positionType=PositionType.viewport;

    position=Vector2(gameRef.canvasSize.x/20, gameRef.canvasSize.y/20);
    size=Vector2(gameRef.canvasSize.y/8,gameRef.canvasSize.y/8);

    final skillsArtboard = await loadArtboard(RiveFile.asset('assets/images/rive/home_button.riv'));
    final rive= RiveStandarAnimation(
        skillsArtboard,
        size
    );
    add(rive);
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    FlameAudio.bgm.stop();
    gameRef.removeAll(gameRef.children);
    Get.offNamed('/');
    return true;
  }
}