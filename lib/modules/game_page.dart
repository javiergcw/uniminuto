import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:template_game/games/dragAndDrop.dart';
import 'package:template_game/games/hangMan.dart';
import 'package:template_game/games/questions.dart';
import 'package:template_game/games/seleccionarCarta.dart';
import 'package:template_game/modules/game_controller.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              body: Obx(() {
                if (controller.myIndex.value == 1) {
                  return QuizPage();
                }
                if (controller.myIndex.value == 2) {
                  return DragDropGame();
                }
                if (controller.myIndex.value == 3) {
                  return HangmanGame();
                }
                if (controller.myIndex.value == 4) {
                  return EncuentraLaPareja();
                }
                /* if (controller.myIndex.value == 5) {
                  return DragDropGame();
                }  */else {
                  return Column(
                    children: [
                      Obx(
                        () => Text("${controller.myIndex}"),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.vertical,
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.levelManager.firstLevel();
                            },
                            child: const Text("Preguntas"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.levelManager.secondLevel();
                            },
                            child: const Text("Drag and drop"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.levelManager.thirdLevel();
                            },
                            child: const Text("El ahorcado"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.levelManager.fourthLevel();
                            },
                            child: const Text("Encuentra la pareja"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.levelManager.finishLevel();
                            },
                            child: const Text("Seccion html con clave"),
                          )
                        ],
                      ),
                    ],
                  );
                }
              }),
            ));
  }
}
