import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double a;
  final double b;

  const ResultScreen({Key? key, required this.a, required this.b}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sum = a + b;
    final cube = sum * sum * sum;
    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${a.toStringAsFixed(2)} + ${b.toStringAsFixed(2)} = ${cube.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
