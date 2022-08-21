import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';

class RiveEnemyBarAnimation extends RiveComponent {
  RiveEnemyBarAnimation(Artboard artboard,Vector2 size)
      : super(
      artboard: artboard,
      size: size,
      antialiasing: false
  );

  SMINumber? number;

  @override
  Future<void>? onLoad() {
    anchor=Anchor.center;
    final controller = StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);

    number = controller.findSMI('Number 1') as SMINumber;
    number?.value=10;

    return super.onLoad();
  }
}