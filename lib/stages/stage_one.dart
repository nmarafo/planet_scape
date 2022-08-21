import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:get/get.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:planet_scape/components/enemy.dart';
import 'package:planet_scape/components/enemy_bar.dart';
import 'package:planet_scape/components/background.dart';
import 'package:planet_scape/components/ground.dart';
import 'package:planet_scape/components/home_button.dart';
import 'package:planet_scape/components/player_bar.dart';
import '../components/player.dart';
import '../components/wall.dart';
import '../utils/controller.dart';

class StageOne extends Forge2DGame with HasTappables,HasDraggables,HasKeyboardHandlerComponents,HasCollisionDetection {
  final Controller c = Get.find();

  @override
  Color backgroundColor() => const Color.fromRGBO(255, 255, 255, 255);

  @override
  Future<void>? onLoad() async{
    //Audio
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'kick.mp3',
      'bsm.mp3'
    ]);

    FlameAudio.bgm.play('bsm.mp3');


    //Camera
    camera.viewport = FixedResolutionViewport(camera.viewport.effectiveSize);

    //Components
    c.player=Player(
      position: Vector2(100,-10),
      size: Vector2(10,10)
    ); //priority=100

    final enemy=Enemy(position: Vector2(190,-10), size: Vector2(10,12),life: 10,difficult: 3);
    await add(enemy);

    //add(Ground(position: Vector2(0,-30), size: Vector2(500,1)));
    add(Ground(position: Vector2.zero(), size: Vector2(500,1)));
    add(Wall(position: Vector2(90,0), size: Vector2(1,500)));
    add(Wall(position: Vector2(200,0), size: Vector2(1,500)));
    await add(c.player)?.then((value) => camera.followBodyComponent(c.player,relativeOffset:Anchor( Anchor.bottomCenter.x,Anchor.bottomCenter.y-0.4)));
    await add(PlayerBar());
    await add(EnemyBar());
    await add(HomeButton());
    await add(Background());

    return super.onLoad();
  }
}