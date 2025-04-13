import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:guessit/main.dart';

void main() {
  testWidgets('Home screen has GUESSIT title', (WidgetTester tester) async {
    // Build the Home screen inside a MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: Home(),
      ),
    );

    // เช็คว่ามีคำว่า GUESSIT จริงในหน้าจอ
    expect(find.text('GUESSIT'), findsOneWidget);

    // เช็คว่ามีปุ่ม LOG IN
    expect(find.text('LOG IN'), findsOneWidget);
  });
}