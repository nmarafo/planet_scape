import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Wall extends BodyComponent {
  final Vector2 position;
  final Vector2 size;

  Wall(
      {
        required this.position,
        required this.size,
      });

  @override
  Future<void> onLoad() {
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

}
