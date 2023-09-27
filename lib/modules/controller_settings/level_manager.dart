import 'package:template_game/modules/game_controller.dart';

class LevelManager {
  final HomeController _controller;

  LevelManager(this._controller);

  void map() {
    _controller.myIndex.value = 0;
  }

  void firstLevel() {
    _controller.myIndex.value = 1;
  }

  void secondLevel() {
    _controller.myIndex.value = 2;
  }

  void thirdLevel() {
    _controller.myIndex.value = 3;
  }

  void fourthLevel() {
    _controller.myIndex.value = 4;
  }

  void finishLevel() {
    _controller.myIndex.value = 5;
  }

  void finishGame() {
    _controller.myIndex.value = 6;
  }
}
