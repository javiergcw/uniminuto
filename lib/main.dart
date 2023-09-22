import 'package:flutter/material.dart';
import 'package:template_game/presentation/design/theme.dart';
import 'package:template_game/presentation/views/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.customTheme,
      home: StartScreen(),
    );
  }
}

