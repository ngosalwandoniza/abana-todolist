// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todolist/main.dart';

void main() {
  testWidgets('add todo shows in list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // enter text
    final input = find.byKey(const Key('todo_input'));
    final addBtn = find.byKey(const Key('add_button'));

    expect(input, findsOneWidget);
    expect(addBtn, findsOneWidget);

    await tester.enterText(input, 'buy milk');
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    expect(find.text('buy milk'), findsOneWidget);
  });
}
