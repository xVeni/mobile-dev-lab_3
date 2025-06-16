import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_3v/main.dart';

void main() {
  testWidgets('App launches and shows input screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CubeSumApp());

    // Должны увидеть заголовок AppBar и кнопку "Рассчитать"
    expect(find.text('Ввод данных'), findsOneWidget);
    expect(find.text('Рассчитать'), findsOneWidget);
  });
}
