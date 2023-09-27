import 'package:get/get.dart';
import 'package:template_game/modules/game_controller.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}