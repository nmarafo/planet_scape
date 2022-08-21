
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:planet_scape/components/player.dart';
import 'package:planet_scape/components/text_component.dart';
import 'package:planet_scape/rive_animations/rive_enemy_animation.dart';
import 'package:planet_scape/stages/stage_one.dart';
import 'package:rive/rive.dart';

import '../rive_animations/rive_player_animation.dart';
import '../utils/controller.dart';
import '../utils/enemy_movements.dart';
import '../utils/player_movements.dart';

class Enemy extends BodyComponent with ContactCallbacks {
  final Vector2 size;
  final Vector2 position;
  int life;
  final double difficult;

  Enemy({
    required this.position,
    required this.size,
    required this.life,
    required this.difficult
  });


  bool canWalk=true;
  bool canJump=true;
  bool canKick=true;
  bool restBool=true;
  bool separationBool=true;

  late Timer beginTimer;
  late Timer endTimer;
  late Timer restTimer;
  late Timer separationTimer;
  late Timer timeToDie;

  final Controller c = Get.find();
  late RiveEnemyAnimation rive;

  @override
  Future<void> onLoad() async{
    priority=99;
    renderBody=false;
    final skillsArtboard = await loadArtboard(RiveFile.asset('assets/images/rive/alien_1.riv'));
    rive= RiveEnemyAnimation(
        skillsArtboard,
        size*2
    );
    add(rive);

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
        }
    );
    restTimer=Timer(
      difficult,
      onTick: (){
        restBool=true;
      }
    );
    separationTimer=Timer(
        5,
        onTick: (){
          separationBool=true;
        }
    );
    timeToDie=Timer(
        1,
        onTick: (){
          rive.die?.value=true;
          final textFinish=TextFinish(
              'win'.tr,
              gameRef.canvasSize,
              position: gameRef.canvasSize/2);
          gameRef.add(textFinish);
        }
    );

    beginTimer.stop();
    endTimer.stop();
    restTimer.stop();
    separationTimer.stop();
    timeToDie.stop();

    return super.onLoad();
  }

  double _distance=0.0;
  bool _separationLeft=false;
  bool _separationRight=false;

  void _separationFunction(){
    if(c.player.body.position.x<body.position.x&&_separationLeft){
      EnemyMovements.leftImpulse(rive);
      body.applyLinearImpulse(Vector2(-200,0));

    }else if(c.player.body.position.x>body.position.x&&!_separationRight){
      EnemyMovements.leftImpulse(rive);
      body.applyLinearImpulse(Vector2(-200,0));
    }else if(c.player.body.position.x>body.position.x&&_separationRight){
      EnemyMovements.rightImpulse(rive);
      body.applyLinearImpulse(Vector2(200,0));
    }else if(c.player.body.position.x<body.position.x&&!_separationLeft){
      EnemyMovements.rightImpulse(rive);
      body.applyLinearImpulse(Vector2(200,0));
    }
  }


  @override
  void update(double dt) {
    beginTimer.update(dt);
    endTimer.update(dt);
    restTimer.update(dt);
    separationTimer.update(dt);
    timeToDie.update(dt);

    _distance=max(c.player.body.position.x, body.position.x)-min(c.player.body.position.x, body.position.x);

    if(body.linearVelocity.x>-10){
      if(c.player.body.position.x<body.position.x&&
      _distance>12){
        EnemyMovements.leftImpulse(rive);
        body.applyLinearImpulse(Vector2(-10,0));
      }
    }
    if(_distance<12){
      body.linearVelocity.x=0;
    }

    if(body.linearVelocity.x<10){
      if(c.player.body.position.x>body.position.x&&
          _distance>12){
        EnemyMovements.rightImpulse(rive);
        body.applyLinearImpulse(Vector2(10,0));
      }
    }

    if(_distance<12){
      body.linearVelocity.x=0;
    }

    if(_distance<15&&_distance>12){
      canKick=true;
      separationBool=true;
      separationTimer.stop();
    }else if(_distance<15&&_distance<12){
      if(separationBool){
        separationBool=false;
        separationTimer.start();
        if(c.player.body.position.x<body.position.x){
          _separationLeft=true;
          _separationRight=false;
        }else{
          _separationLeft=false;
          _separationRight=true;
        }
      }
      _separationFunction();
    }


    if(canKick&&restBool){
      restBool=false;
      restTimer.start();
      _kickFunction(EnemyMovements.punch(rive));
    }

    super.update(dt);
  }
  
  void createFixture(){
    final shape = PolygonShape();
    bool _isLeft=false;
    c.player.body.position.x<body.position.x?_isLeft=true:_isLeft=false;
    double fixturePosition=_isLeft ? -8:8;
    shape.setAsBox(size.x/6, size.y/10,Vector2(fixturePosition,-3),0);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0
      ..density = 0.1
      ..filter.groupIndex=1
      //..filter.categoryBits=1
      //..filter.maskBits=3
      ..friction = 0;
    body.createFixture(fixtureDef);
  }
  
  void destroyFixture(){
    body.destroyFixture(body.fixtures.last);
  }

  void _kickFunction(EnemyMovements movements){
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
      ..filter.groupIndex=2
      ..filter.categoryBits=4
      ..filter.maskBits=2
      ..friction = 0;

    final fixtureDef2 = FixtureDef(shapeDown)
      ..restitution = 0
      ..density = 0.1
      ..filter.groupIndex=4
      ..filter.categoryBits=8
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
    if(other is Player){
      if(contact.bodyA.fixtures[0].filterData.categoryBits==1){
        FlameAudio.play('kick.mp3');
        c.rivePlayerAnimation?.kiktome?.fire();
        c.player.life--;
        c.rivePlayerBarAnimation?.number?.value--;
        if(c.player.life==0){
          c.rivePlayerAnimation?.die?.value=true;
          c.player.timeToDie.start();
          c.player.canKick=false;
        }
        print('player=${c.player.life}');
      }
    }
    super.beginContact(other, contact);
  }

}