import 'package:app_layout/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // ALTERADO: novo nome da aplicação
      title: "TaskFlow",
      home: HomeScreen()
    );
  }
}
