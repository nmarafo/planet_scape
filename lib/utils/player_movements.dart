import 'package:flame/components.dart';
import 'package:get/get.dart';

import '../components/player.dart';
import 'controller.dart';

class PlayerMovements {

  final Controller c = Get.find();

  PlayerMovements.leftImpulse(){
    if(!c.rivePlayerAnimation!.isFlippedHorizontally) {
      c.rivePlayerAnimation?.flipHorizontally();
    }
    if(c.player.body.linearVelocity.x>-20){
      c.player.body.applyLinearImpulse(Vector2(-200,0));
    }
    c.rivePlayerAnimation?.walking?.value=true;
  }

  PlayerMovements.rightImpulse(){
    if(c.rivePlayerAnimation!.isFlippedHorizontally){
      c.rivePlayerAnimation?.flipHorizontallyAroundCenter();
    }
    if(c.player.body.linearVelocity.x<20){
      c.player.body.applyLinearImpulse(Vector2(200,0));
    }
    c.rivePlayerAnimation?.walking?.value=true;
  }

  PlayerMovements.upImpulse(){
    c.player.body.applyLinearImpulse(Vector2(c.player.body.linearVelocity.x,-200));
    c.rivePlayerAnimation?.jump?.fire();
  }

  PlayerMovements.punch(){
    c.rivePlayerAnimation?.punch?.fire();
  }

  PlayerMovements.kick(){
    c.rivePlayerAnimation?.kik?.fire();
  }

  PlayerMovements.downImpulse(){

  }
}