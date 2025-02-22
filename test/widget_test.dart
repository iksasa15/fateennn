// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
/*
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fateen/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fateen/main.dart'; // ✅ تأكد من صحة الاستيراد

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // ✅ بناء التطبيق وتحميله
    await tester.pumpWidget(MyApp()); // ❌ إزالة `const` لأن `MyApp` ليست ثابتة

    // ✅ التحقق من أن العداد يبدأ من 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // ✅ الضغط على زر "+" لزيادة العداد
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // ✅ التحقق من أن العداد أصبح 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
