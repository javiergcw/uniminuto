import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:template_game/presentation/layout/layout_main.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return /*   Container(); */ LayoutMain(
      myAppBar: myAppBar(context),
      asideSection: asideSection(),
      profileSection: profileSection(context),
      gameSection: Container(),
    );
  }
}

Widget myAppBar(context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Container(
          color: Colors.grey,
          height: MediaQuery.of(context).size.height,
          width: 100,
        ),
        const SizedBox(
          width: 10,
        ),
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 10,
          children: [
            const Text("Sin rostro sin rastro"),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 300,
              animation: true,
              lineHeight: 25.0,
              animationDuration: 2000,
              percent:
                  0.8, // Representa el 80%. Puedes cambiarlo según tu necesidad.
              center: const Text(
                "80.0%",
                style: TextStyle(color: Colors.white),
              ),
              barRadius: const Radius.circular(10),
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              progressColor: Theme.of(context).primaryColor, // Color primary
              leading: null, // Elimina el padding del inicio
              trailing: null, // Elimina el padding del final
            ),
          ],
        ),
        const Spacer(),
        Image.asset('assets/logo.png')
      ],
    ),
  );
}

Widget asideSection() {
  return Column(
    children: [
      Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                10.0), // Radio para la esquina superior izquierda
            topRight:
                Radius.circular(10.0), // Radio para la esquina superior derecha
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Wrap(
        runAlignment: WrapAlignment.center,
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 30,
        children: [
          Icon(
            Icons.home_outlined,
            color: Color(0xffF2F1F5),
            size: 45,
          ),
          Icon(
            Icons.star_outline,
            color: Color(0xffF2F1F5),
            size: 45,
          ),
          Icon(
            Icons.info_outline,
            color: Color(0xffF2F1F5),
            size: 45,
          ),
        ],
      ),
    ],
  );
}

Widget profileSection(context) {
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), // Esquina superior izquierda
            topRight: Radius.circular(10.0), // Esquina superior derecha
          ),
        ),
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Stack(
                clipBehavior:
                    Clip.none, // Para que el IconButton pueda salirse del stack
                children: [
                  const CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.amber,
                    // Puedes agregar una imagen aquí si lo necesitas con backgroundImage
                  ),
                  Positioned(
                    right: 5,
                    top: 80,
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 20.0),
                        onPressed: () {
                          // Aquí puedes manejar la acción del botón
                        },
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              const Wrap(
                spacing: 10,
direction: Axis.vertical,
                children: [


                  Text('Javier de Jesus Garcia Carrillo'),
                  Text('Estudiante'),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}
