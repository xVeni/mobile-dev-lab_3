import 'package:flutter/material.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ввод данных')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _aController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Число a',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty
                        ? 'Введите число a'
                        : (double.tryParse(v) == null ? 'Неверный формат' : null),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Число b',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty
                        ? 'Введите число b'
                        : (double.tryParse(v) == null ? 'Неверный формат' : null),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    onChanged: (v) => setState(() => _agreed = v ?? false),
                  ),
                  const Expanded(child: Text('Согласен на обработку данных')),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  if (!_agreed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Пожалуйста, подтвердите согласие')),
                    );
                    return;
                  }
                  final a = double.parse(_aController.text);
                  final b = double.parse(_bController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(a: a, b: b),
                    ),
                  );
                },
                child: const Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
