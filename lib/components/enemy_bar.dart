import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:get/get.dart';
import 'package:planet_scape/rive_animations/rive_player_bar_animation.dart';
import 'package:planet_scape/stages/stage_one.dart';
import 'package:rive/rive.dart';

import '../rive_animations/rive_enemy_bar_animation.dart';
import '../utils/controller.dart';


class EnemyBar extends PositionComponent with HasGameRef<StageOne>{

  final Controller c = Get.find();

  @override
  Future<void> onLoad() async {
    priority=100;
    positionType=PositionType.viewport;

    position=Vector2(gameRef.canvasSize.x/1.4, gameRef.canvasSize.y/5);
    size=Vector2(gameRef.canvasSize.y/3,gameRef.canvasSize.y/3);

    final skillsArtboard = await loadArtboard(RiveFile.asset('assets/images/rive/enemy_bar.riv'));

    c.riveEnemyBarAnimation= RiveEnemyBarAnimation(
      skillsArtboard,
      size,
    );

    add(c.riveEnemyBarAnimation!);
  }
}