import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:template_game/modules/game_controller.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final String jsonSample = '''{
    "preguntas": [
      {
        "texto": "¿Cuál es la capital de Francia?",
        "opciones": [
          { "respuesta": "Madrid", "correcta": false },
          { "respuesta": "Berlín", "correcta": false },
          { "respuesta": "París", "correcta": true },
          { "respuesta": "Lisboa", "correcta": false }
        ]
      },
      {
        "texto": "¿Cuántos lados tiene un triángulo?",
        "opciones": [
          { "respuesta": "2", "correcta": false },
          { "respuesta": "3", "correcta": true },
          { "respuesta": "4", "correcta": false },
          { "respuesta": "5", "correcta": false }
        ]
      }
    ]
  }''';

  late List preguntas;
  int currentQuestion = 0;
  int? selectedAnswer;

  @override
  void initState() {
    super.initState();
    preguntas = jsonDecode(jsonSample)['preguntas'];
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
                Expanded(
                  child: Center(
                    child: Text(preguntas[currentQuestion]['texto']),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.levelManager.map();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                Column(
                  children: List.generate(
                    preguntas[currentQuestion]['opciones'].length,
                    (index) => ListTile(
                      title: Text(preguntas[currentQuestion]['opciones'][index]
                          ['respuesta']),
                      leading: Radio(
                        value: index,
                        groupValue: selectedAnswer,
                        onChanged: (int? value) {
                          setState(() {
                            selectedAnswer = value;
                          });
                        },
                      ),
                    ),
                  ),
                ), // ... [Toda tu importación y clases anteriores]

                ElevatedButton(
                  onPressed: () {
                    if (preguntas[currentQuestion]['opciones'][selectedAnswer!]
                        ['correcta']) {
                      if (currentQuestion < preguntas.length - 1) {
                        setState(() {
                          currentQuestion++;
                          selectedAnswer = null;
                        });
                      } else {
                        // Al final del quiz
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('¡Felicidades!'),
                            content: const Text('Has superado los niveles'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Cerrar el dialogo
                                  Navigator.of(context).pop();
                                  // Navegar a HomePage
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Incorrecto'),
                          content: const Text('Inténtalo nuevamente'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Siguiente'),
                ),
              ],
            ))));
  }
}
