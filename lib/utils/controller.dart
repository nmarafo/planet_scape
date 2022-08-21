import 'package:get/get.dart';
import 'package:planet_scape/rive_animations/rive_enemy_animation.dart';
import 'package:planet_scape/rive_animations/rive_enemy_bar_animation.dart';
import 'package:planet_scape/rive_animations/rive_player_bar_animation.dart';

import '../components/player.dart';
import '../rive_animations/rive_player_animation.dart';

class Controller extends GetxController{
  late Player player;
  RivePlayerAnimation? rivePlayerAnimation;
  RivePlayerBarAnimation? rivePlayerBarAnimation;
  RiveEnemyBarAnimation? riveEnemyBarAnimation;
}