import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:template_game/modules/game_controller.dart';

class EncuentraLaPareja extends StatefulWidget {
  @override
  _EncuentraLaParejaState createState() => _EncuentraLaParejaState();
}

class _EncuentraLaParejaState extends State<EncuentraLaPareja> {
  final String jsonData = ''' 
  {
    "parejas": [
      {"palabra": "gato", "imagen": "https://i.imgur.com/NwF7IG1.png"},
      {"palabra": "perro", "imagen": "https://i.imgur.com/yjIcE9n.png"},
      {"palabra": "pez", "imagen": "https://i.imgur.com/dRaTyqa.png"}
    ]
  }
  ''';

  late List<Pareja> parejas;
  late List<ItemCarta> cartas;
  ItemCarta? primeraSeleccion;
  ItemCarta? segundaSeleccion;
  bool bloquearInteraccion = false;

  @override
  void initState() {
    super.initState();
    parejas = (json.decode(jsonData)['parejas'] as List)
        .map((e) => Pareja(palabra: e['palabra'], imagen: e['imagen']))
        .toList();

    iniciarJuego();
  }

  void iniciarJuego() {
    cartas = [];
    for (var pareja in parejas) {
      cartas.add(ItemCarta(
          tipo: TipoCarta.palabra, valor: pareja.palabra, esVisible: false));
      cartas.add(ItemCarta(
          tipo: TipoCarta.imagen, valor: pareja.imagen, esVisible: false));
    }
    cartas.shuffle(); // Mezclamos las cartas aleatoriamente
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: ((controller) => Scaffold(
              appBar: AppBar(title: Text('Encuentra la Pareja')),
              body: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.levelManager.map();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                3, // Cambiado a 3 para ver 6 cartas a la vez
                            childAspectRatio:
                                0.7, // Ajustar según la proporción deseada
                          ),
                          itemCount: cartas.length,
                          itemBuilder: (context, index) =>
                              buildCarta(cartas[index], index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget buildCarta(ItemCarta carta, int index) {
    return GestureDetector(
      onTap: bloquearInteraccion ? null : () => seleccionarCarta(index),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(8.0),
        color: carta.esVisible ? Colors.white : Colors.blue,
        child: carta.esVisible
            ? (carta.tipo == TipoCarta.palabra
                ? Center(child: Text(carta.valor))
                : Image.network(carta.valor))
            : Container(),
      ),
    );
  }

  void seleccionarCarta(int index) {
    setState(() {
      if (primeraSeleccion == null) {
        primeraSeleccion = cartas[index];
        cartas[index].esVisible = true;
      } else {
        segundaSeleccion = cartas[index];
        cartas[index].esVisible = true;

        bloquearInteraccion = true;

        Pareja? parejaCorrespondiente = parejas.firstWhere(
          (pareja) =>
              pareja.palabra == primeraSeleccion!.valor ||
              pareja.imagen == primeraSeleccion!.valor,
        );

        if (parejaCorrespondiente != null &&
            (parejaCorrespondiente.palabra == segundaSeleccion!.valor ||
                parejaCorrespondiente.imagen == segundaSeleccion!.valor)) {
          // Las cartas coinciden
          Fluttertoast.showToast(
              msg: "Correcto!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              cartas.remove(primeraSeleccion!);
              cartas.remove(segundaSeleccion!);
              primeraSeleccion = null;
              segundaSeleccion = null;
              bloquearInteraccion = false;

              // Verificar si todas las cartas han sido emparejadas
              if (cartas.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('¡Felicidades!'),
                    content: Text('Has completado el nivel.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          iniciarJuego();
                        },
                        child: Text('Continuar'),
                      ),
                    ],
                  ),
                );
              }
            });
          });
        } else {
          // Las cartas no coinciden
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              primeraSeleccion!.esVisible = false;
              segundaSeleccion!.esVisible = false;
              primeraSeleccion = null;
              segundaSeleccion = null;
              bloquearInteraccion = false;
            });
          });
        }
      }
    });
  }
}

enum TipoCarta { palabra, imagen }

class ItemCarta {
  final TipoCarta tipo;
  final String valor;
  bool esVisible;

  ItemCarta({required this.tipo, required this.valor, this.esVisible = false});
}

class Pareja {
  final String palabra;
  final String imagen;

  Pareja({required this.palabra, required this.imagen});
}
