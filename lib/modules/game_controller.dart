import 'package:get/get.dart';
import 'package:template_game/modules/controller_settings/level_manager.dart';

class HomeController extends GetxController {
var myIndex = 0.obs;
late LevelManager levelManager;

  @override
  void onInit() {
    super.onInit();
    levelManager = LevelManager(this);
  }
}
