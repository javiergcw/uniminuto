import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {required this.child,
      required this.width,
      required this.height,
      super.key});

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xffF2F1F5),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
