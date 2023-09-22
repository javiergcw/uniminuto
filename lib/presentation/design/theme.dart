import 'package:flutter/material.dart';

class MyTheme {
  static final ThemeData customTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blue[100],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ),
    useMaterial3: true,
    // Otros ajustes de tema aquí, como las fuentes, los estilos de texto, etc.
  );
}
