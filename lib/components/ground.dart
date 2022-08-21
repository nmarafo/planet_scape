import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../rive_animations/rive_standard_animation.dart';
import '../utils/controller.dart';

class Ground extends BodyComponent with ContactCallbacks{
  final Vector2 position;
  final Vector2 size;

  Ground(
      {
        required this.position,
        required this.size,
      });

  final Controller c = Get.find();

  @override
  Future<void> onLoad() async{
    renderBody=false;
    return super.onLoad();
  }

  @override
  Body createBody() {
    final shape = PolygonShape();

    shape.setAsBoxXY(size.x, size.y);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0
      ..filter.groupIndex=3
      ..filter.categoryBits=7
      //..filter.maskBits=2
      ..density=1.0
      ..friction = 0;

    final bodyDef = BodyDef()
      ..userData = this // To be able to determine object in collision
      ..position=position
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    c.player.canJump=true;
    super.beginContact(other, contact);
  }

  @override
  void endContact(Object other, Contact contact) {
    super.endContact(other, contact);
  }

}
