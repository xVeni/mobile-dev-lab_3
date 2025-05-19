import 'package:flutter/material.dart';

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
      home: const InputScreen(), // Показываем первый экран
    );
  }
}

/// Первый экран с полями ввода и чекбоксом
class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>(); // Ключ формы для валидации
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  bool _agreed = false; // Статус чекбокса

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ввод данных'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Привязываем ключ
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Поле для числа a
              TextFormField(
                controller: _aController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Число a',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Проверяем, что поле не пустое и содержит число
                  if (value == null || value.isEmpty) {
                    return 'Введите число a';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Поле для числа b
              TextFormField(
                controller: _bController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Число b',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Проверяем, что поле не пустое и содержит число
                  if (value == null || value.isEmpty) {
                    return 'Введите число b';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Чекбокс для согласия на обработку данных
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    onChanged: (newValue) {
                      setState(() {
                        _agreed = newValue ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text('Согласен на обработку данных'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Кнопка для перехода на второй экран
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Проверяем форму и чекбокс
                    if (_formKey.currentState!.validate()) {
                      if (!_agreed) {
                        // Если чекбокс не выбран, показываем сообщение
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Пожалуйста, подтвердите согласие'),
                          ),
                        );
                        return;
                      }
                      // Парсим введенные значения и переходим на экран результатов
                      final double a = double.parse(_aController.text);
                      final double b = double.parse(_bController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(a: a, b: b),
                        ),
                      );
                    }
                  },
                  child: const Text('Рассчитать'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Второй экран для отображения результата
class ResultScreen extends StatelessWidget {
  final double a;
  final double b;

  const ResultScreen({Key? key, required this.a, required this.b}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Вычисляем (a + b)^3
    double sum = a + b;
    double cubeSum = sum * sum * sum;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Отображаем формулу и результат
              Text(
                '(\$a + \$b)^3 =',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                cubeSum.toStringAsFixed(2), // Форматируем до 2 знаков после запятой
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              // Кнопка "Назад" для возврата на первый экран
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
