import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';

class RivePlayerAnimation extends RiveComponent {
  RivePlayerAnimation(Artboard artboard,Vector2 size)
      : super(
      artboard: artboard,
      size: size,
      antialiasing: false
  );

  SMIBool? walking;
  SMITrigger? jump;
  SMITrigger? kik;
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

    jump=controller.findSMI('jump') as SMITrigger;
    kik=controller.findSMI('kik') as SMITrigger;
    kiktome=controller.findSMI('kicktome') as SMITrigger;
    punch=controller.findSMI('punch') as SMITrigger;
    die = controller.findInput<bool>('die') as SMIBool;
    die?.value=false;

    return super.onLoad();
  }
}