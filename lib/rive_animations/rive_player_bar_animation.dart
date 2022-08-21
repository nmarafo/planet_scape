import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';

class RivePlayerBarAnimation extends RiveComponent {
  RivePlayerBarAnimation(Artboard artboard,Vector2 size)
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

    return super.onLoad();
  }
}