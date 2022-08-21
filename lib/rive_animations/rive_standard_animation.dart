import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';

class RiveStandarAnimation extends RiveComponent {
  RiveStandarAnimation(Artboard artboard,Vector2 size)
      : super(
      artboard: artboard,
      size: size,
      antialiasing: false
  );

  @override
  Future<void>? onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);

    return super.onLoad();
  }
}