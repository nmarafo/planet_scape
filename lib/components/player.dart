
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:planet_scape/components/enemy.dart';
import 'package:planet_scape/components/text_component.dart';
import 'package:planet_scape/stages/stage_one.dart';
import 'package:rive/rive.dart';

import '../rive_animations/rive_player_animation.dart';
import '../utils/controller.dart';
import '../utils/player_movements.dart';

class Player extends BodyComponent with KeyboardHandler,ContactCallbacks {
  final Vector2 size;
  final Vector2 position;

  Player({
    required this.position,
    required this.size,
  });


  bool canWalk=true;
  bool canJump=true;
  bool canKick=true;
  late Timer beginTimer;
  late Timer endTimer;
  int life=3;

  late Timer timeToDie;

  final Controller c = Get.find();

  @override
  Future<void> onLoad() async{
    priority=100;
    renderBody=false;
    final skillsArtboard = await loadArtboard(RiveFile.asset('assets/images/rive/player.riv'));
    c.rivePlayerAnimation= RivePlayerAnimation(
        skillsArtboard,
        size*2
    );
    add(c.rivePlayerAnimation!);

    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyA: (keysPressed) {
            body.linearVelocity.x=0;
            c.rivePlayerAnimation?.walking?.value=false;
            return false;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            body.linearVelocity.x=0;
            c.rivePlayerAnimation?.walking?.value=false;
            return false;
          },
          LogicalKeyboardKey.keyW: (keysPressed) {
            return false;
          },
          LogicalKeyboardKey.keyS: (keysPressed) {
            return false;
          },
          LogicalKeyboardKey.space: (keysPressed) {
            return false;
          },
        },
        keyDown: {
          LogicalKeyboardKey.keyA: (keysPressed) {
            if(canWalk&&canKick){
              PlayerMovements.leftImpulse();
            }
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            if(canWalk&&canKick){
              PlayerMovements.rightImpulse();
            }
            return true;
          },
          LogicalKeyboardKey.keyW: (keysPressed) {
            if(keysPressed.contains(LogicalKeyboardKey.space)&&canKick){
              _kickFunction(PlayerMovements.kick());
            }else{
              if(canJump&&canKick){
                canJump=false;
                PlayerMovements.upImpulse();
              }
            }
            return true;
          },
          LogicalKeyboardKey.space: (keysPressed) {
            if(canKick){
              _kickFunction(PlayerMovements.punch());
            }
            return true;
          },
        },
      ),
    );

    beginTimer=Timer(
        0.4,
        onTick: () {
          createFixture();
          endTimer.start();
        }
    );
    endTimer=Timer(
        0.1,
        onTick: () {
          destroyFixture();
          canKick=true;
        }
    );
    timeToDie=Timer(
        1,
        onTick: (){
          final textFinish=TextFinish(
              'dead'.tr,
              gameRef.canvasSize,
              size: gameRef.canvasSize,
              align: Anchor.center,
              position: gameRef.canvasSize/2);
          gameRef.add(textFinish);
          //removeFromParent();
        }
    );

    beginTimer.stop();
    endTimer.stop();
    timeToDie.stop();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    beginTimer.update(dt);
    endTimer.update(dt);
    timeToDie.update(dt);
    super.update(dt);
  }
  
  void createFixture(){
    final shape = PolygonShape();
    double fixturePosition=c.rivePlayerAnimation!.isFlippedHorizontally ? -8:8;
    shape.setAsBox(size.x/6, size.y/10,Vector2(fixturePosition,-3),0);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0
      ..density = 0.1
      ..filter.groupIndex=2
      ..filter.categoryBits=2
      ..filter.maskBits=4
      ..friction = 0;
    body.createFixture(fixtureDef);
  }
  
  void destroyFixture(){
    body.destroyFixture(body.fixtures.last);
  }

  void _kickFunction(PlayerMovements movements){
    if(canKick){
      canKick=false;
      movements;
      beginTimer.stop();
      beginTimer.start();
    }
  }

  @override
  Body createBody() {
    final shapeUp = PolygonShape();
    final shapeDown = PolygonShape();

    shapeUp.setAsBox(size.x/2, size.y/1.25,Vector2(0,-0.5),0);
    shapeDown.setAsBox(size.x/2, size.y/10,Vector2(0,8),0);


    final fixtureDef = FixtureDef(shapeUp)
      ..restitution = 0
      ..density = 0.1
      ..filter.groupIndex=1
      ..filter.categoryBits=1
      ..filter.maskBits=3
      ..friction = 0;

    final fixtureDef2 = FixtureDef(shapeDown)
      ..restitution = 0
      ..density = 0.1
      ..filter.groupIndex=3
      ..filter.categoryBits=5
      ..filter.maskBits=7
      ..friction = 0;

    final bodyDef = BodyDef()
      ..userData = this // To be able to determine object in collision
      ..position = position
      ..fixedRotation=true
      ..type = BodyType.dynamic;

    body=world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..createFixture(fixtureDef2);

    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if(other is Enemy){
      if(contact.bodyA.fixtures[0].filterData.categoryBits==4){
        FlameAudio.play('kick.mp3');
        other.life--;
        c.riveEnemyBarAnimation?.number?.value--;
        other.rive.kiktome?.fire();
        print('enemy=${other.life}');
        if(other.life==0){
          other.timeToDie.start();
          other.canKick=false;
          other.restBool=false;
        }
      }
    }
    super.beginContact(other, contact);
  }


}