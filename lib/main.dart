import 'package:flutter/material.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(const CubeSumApp());
}

class CubeSumApp extends StatelessWidget {
  const CubeSumApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор кубов суммы',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InputScreen(),
    );
  }
}
