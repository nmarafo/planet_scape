import 'package:flame/components.dart';
import 'package:get/get.dart';
import 'package:planet_scape/rive_animations/rive_enemy_animation.dart';

import '../components/player.dart';
import '../rive_animations/rive_player_animation.dart';
import 'controller.dart';

class EnemyMovements {

  final Controller c = Get.find();

  EnemyMovements.leftImpulse(RiveEnemyAnimation rive){
    if(!rive.isFlippedHorizontally) {
      rive.flipHorizontally();
    }

    rive.walking?.value=true;
  }

  EnemyMovements.rightImpulse(RiveEnemyAnimation rive){
    if(rive.isFlippedHorizontally){
      rive.flipHorizontallyAroundCenter();
    }

    rive.walking?.value=true;
  }

  EnemyMovements.punch(RiveEnemyAnimation rive){
    rive.punch?.fire();
  }

  EnemyMovements.kick(RiveEnemyAnimation rive){
    rive.kick?.fire();
  }

  EnemyMovements.downImpulse(){

  }
}