import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ConfigesApp());
}

class ConfigesApp extends StatelessWidget {
  const ConfigesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'CONFIGES ABDELLALI PRO',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),

      home: const HomeScreen(),
    );
  }
}
