import 'package:calculadora_basica/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Prueba de operaciones básicas de la calculadora', (WidgetTester tester) async {
    // Construye la aplicación de la calculadora.
    await tester.pumpWidget(CalculadoraApp());

    // Verifica que la pantalla inicial muestra "0".
    expect(find.text('0'), findsOneWidget);

    // Prueba de suma: 1 + 1 = 2
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('2.0'), findsOneWidget);

    // Prueba de multiplicación: 2 x 3 = 6
    await tester.tap(find.text('C'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('x'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('6.0'), findsOneWidget);

    // Prueba de división: 8 ÷ 4 = 2
    await tester.tap(find.text('C'));
    await tester.pump();
    await tester.tap(find.text('8'));
    await tester.pump();
    await tester.tap(find.text('÷'));
    await tester.pump();
    await tester.tap(find.text('4'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('2.0'), findsOneWidget);
  });
}
