import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:template_game/modules/game_controller.dart';

class DragDropGame extends StatefulWidget {
  @override
  _DragDropGameState createState() => _DragDropGameState();
}

class _DragDropGameState extends State<DragDropGame> {
  List<Map<String, dynamic>> juegos = [
    {"icono": Icons.pets, "palabra1": "Gat", "palabra2": "ito"},
    {"icono": Icons.wb_sunny, "palabra1": "So", "palabra2": "lar"},
    {"icono": Icons.flood, "palabra1": "Flo", "palabra2": "recer"}
  ];

  late List<String?> targetWords;

  @override
  void initState() {
    super.initState();
    targetWords = List.filled(juegos.length, null);

    juegos.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: ((controller) => Scaffold(
              appBar: AppBar(
                title: const Text('Drag & Drop Game'),
              ),
              body: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.levelManager.map();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  // Arriba: iconos y palabra1 con área de drop
                  ElevatedButton(
                    onPressed: validateAnswers,
                    child: const Text("Validar"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(juegos.length, (index) {
                      return Column(
                        children: [
                          Icon(juegos[index]['icono']),
                          DragTarget<String>(
                            onWillAccept: (receivedItem) {
                              return true;
                            },
                            onAccept: (receivedItem) {
                              setState(() {
                                int? prevIndex =
                                    targetWords.indexOf(receivedItem);
                                if (prevIndex != -1) {
                                  targetWords[prevIndex] = null;
                                }
                                targetWords[index] = receivedItem;
                              });
                            },
                            builder: (context, acceptedItems, rejectedItems) {
                              return Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(juegos[index]['palabra1']),
                                    SizedBox(height: 5),
                                    if (targetWords[index] != null)
                                      Row(
                                        children: [
                                          Text(targetWords[index]!),
                                          IconButton(
                                            icon: Icon(Icons.close,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                targetWords[index] = null;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    else
                                      Text(""),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 50), // Separación
                  // Abajo: palabras2 draggable
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(juegos.length, (index) {
                      return Draggable<String>(
                        data: juegos[index]['palabra2'],
                        child: targetWords.contains(juegos[index]['palabra2'])
                            ? Container()
                            : Text(juegos[index]['palabra2']),
                        feedback: Material(
                          child: Text(juegos[index]['palabra2']),
                        ),
                        childWhenDragging: Container(),
                      );
                    }),
                  ),
                ],
              ),
            )));
  }

  void validateAnswers() {
    bool allCorrect = true;

    for (int i = 0; i < juegos.length; i++) {
      if (targetWords[i] != juegos[i]['palabra2']) {
        allCorrect = false;
      }
    }

    if (allCorrect) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('¡Felicidades!'),
          content: Text('Has completado el nivel.'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      setState(() {
        for (int i = 0; i < juegos.length; i++) {
          if (targetWords[i] != juegos[i]['palabra2']) {
            targetWords[i] = null;
          }
        }
      });
    }
  }
}
