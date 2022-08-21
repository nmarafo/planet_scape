import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:planet_scape/utils/messages/messages_stage_one.dart';

import '../controller.dart';

class Messages extends Translations {
  final Controller c = Get.find();
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': enUsStageOne(),
      'en_UK': enUkStageOne(),
      'es_ES': esEsStageOne()
    };
  }
}