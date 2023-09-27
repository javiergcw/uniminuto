
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template_game/modules/game_binding.dart';
import 'package:template_game/modules/game_page.dart';
import 'package:template_game/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.game,
      page: () => GamePage(),
      binding: GameBinding(),
    ),
  ];
}