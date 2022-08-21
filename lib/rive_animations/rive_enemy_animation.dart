import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';

class RiveEnemyAnimation extends RiveComponent {
  RiveEnemyAnimation(Artboard artboard,Vector2 size)
      : super(
      artboard: artboard,
      size: size,
      antialiasing: false
  );

  SMIBool? walking;
  SMITrigger? kick;
  SMITrigger? kiktome;
  SMITrigger? punch;
  SMIBool? die;

  @override
  Future<void>? onLoad() {
    anchor=Anchor.center;
    final controller = StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);

    walking = controller.findInput<bool>('walking') as SMIBool;
    walking?.value=false;

    kick=controller.findSMI('kick') as SMITrigger;
    kiktome=controller.findSMI('kiktome') as SMITrigger;
    punch=controller.findSMI('punch') as SMITrigger;
    die = controller.findInput<bool>('die') as SMIBool;
    die?.value=false;

    return super.onLoad();
  }
}