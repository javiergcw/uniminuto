import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:template_game/modules/game_controller.dart';

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  final String jsonData = '''
  {
    "niveles": [
      {
        "vidas": 5,
        "palabra": "unicornio",
        "pistas": ["Es un animal mitológico", "A menudo se representa con un cuerno en la frente", "Es un ser fantástico"]
      },
      {
        "vidas": 5,
        "palabra": "pez",
        "pistas": ["Es un animal acuático", "Tiene aletas y escamas", "Vive en ríos y mares"]
      }
    ]
  }
  ''';

  late List<Map<String, dynamic>> niveles;
  late int nivelActual;
  late int vidas;
  late String palabraActual;
  late List<String> pistas;
  late int pistaActual;
  late String palabraMostrada;
  late List<String> letrasSeleccionadas;

  @override
  void initState() {
    super.initState();
    niveles = List<Map<String, dynamic>>.from(json.decode(jsonData)['niveles']);
    iniciarNivel(0);
  }

  void iniciarNivel(int nivel) {
    nivelActual = nivel;
    vidas = niveles[nivelActual]['vidas'];
    palabraActual = niveles[nivelActual]['palabra'];
    pistas = List<String>.from(niveles[nivelActual]['pistas']);
    pistaActual = 0;
    palabraMostrada = palabraActual.replaceAll(RegExp(r'[a-zA-ZñÑ]'), '_');
    letrasSeleccionadas = [];
  }

  void seleccionarLetra(String letra) {
    setState(() {
      letrasSeleccionadas.add(letra);

      if (!palabraActual.contains(letra)) {
        vidas -= 1;
        if (pistaActual < pistas.length) {
          pistaActual += 1;
        }
        if (vidas <= 0) {
          mostrarDialogoPerdida();
        }
      } else {
        // Actualizar la palabra mostrada
        List<String> temp = palabraMostrada.split('');
        for (int i = 0; i < palabraActual.length; i++) {
          if (palabraActual[i] == letra) {
            temp[i] = letra;
          }
        }
        palabraMostrada = temp.join();

        if (!palabraMostrada.contains('_')) {
          // Palabra completada, pasar al siguiente nivel o terminar el juego
          if (nivelActual < niveles.length - 1) {
            iniciarNivel(nivelActual + 1);
          } else {
            mostrarDialogoFinalizacion();
          }
        }
      }
    });
  }

  void mostrarDialogoPerdida() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Haz perdido!'),
          content: const Text('Inténtalo nuevamente.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Reintentar'),
              onPressed: () {
                setState(() {
                  iniciarNivel(nivelActual); // Reinicia el nivel actual
                  Navigator.of(context).pop(); // Cierra el diálogo
                });
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoFinalizacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Felicidades!'),
          content: const Text('Haz completado el juego.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.of(context).pop(); // Cierra el diálogo

                // Aquí puedes agregar cualquier acción adicional, como regresar a la pantalla principal.
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: ((controller) => Scaffold(
            appBar: AppBar(
              title: const Text('Drag & Drop Game'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      controller.levelManager.map();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                Text('${nivelActual + 1}/${niveles.length}'),
                // Display lives remaining with heart icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(width: 10),
                    Text('$vidas'),
                  ],
                ),
                SizedBox(height: 20),

                // Display current hint
                Column(
                  children: List.generate(pistaActual + 1, (index) {
                    if (index < pistas.length) {
                      return Text('Pista ${index + 1}: ${pistas[index]}');
                    }
                    return SizedBox
                        .shrink(); // Return an empty widget if no more hints
                  }),
                ),
                SizedBox(height: 20),

                // Display word with underscores
                Text(palabraMostrada, style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),

                // Display alphabet letters for user to select
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children:
                      'abcdefghijklmnñopqrstuvwxyz'.split('').map((letra) {
                    return GestureDetector(
                      onTap: () {
                        if (!letrasSeleccionadas.contains(letra)) {
                          seleccionarLetra(letra);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: letrasSeleccionadas.contains(letra)
                              ? Colors.grey
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:
                            Text(letra, style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ))));
  }
}
