import 'package:flutter/material.dart';
import 'package:template_game/presentation/widgets/roundedContainer.dart';

class LayoutMain extends StatelessWidget {
  const LayoutMain({
    required this.myAppBar,
    required this.asideSection,
    required this.profileSection,
    required this.gameSection,
    super.key,
  });

  final Widget myAppBar;
  final Widget asideSection;
  final Widget profileSection;
  final Widget gameSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 5, left: 20.0, right: 20.0),
        child: Column(
          children: [
            RoundedContainer(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: myAppBar,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: RoundedContainer(
                      width: null,
                      height: null,
                      child: Container(
                        height: double.infinity,
                        child: asideSection,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 4,
                    child: RoundedContainer(
                      width: null,
                      height: null,
                      child: Container(
                         height: double.infinity,
                        child: profileSection),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 8,
                    child: RoundedContainer(
                      width: null,
                      height: null,
                      child: gameSection,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  "Derechos reservados © 2023",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
