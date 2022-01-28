// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tdd/main.dart';
void main() {
  group('Widget Tests',(){
    testWidgets('Counter increments with findByIcon', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());
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
    testWidgets('Counter increments with find.byToolTip & byType', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await  tester.tap(find.byTooltip("Increment"));
      await  tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsNothing);
      expect(find.text('2'), findsOneWidget);
    });
    testWidgets('Enter text and check', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.enterText(find.byType(TextField), "Count");
      await tester.pump();
      expect(find.text('Count'),findsOneWidget);
    });
    testWidgets('find Widget with byKey', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.byKey(ValueKey("key")),findsOneWidget);
    });
    testWidgets('find Widget with textContaining', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.textContaining("You"),findsOneWidget);
    });
    testWidgets('find Widget with Image', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.widgetWithImage(Container, AssetImage('assets/images/splash.jpg')),findsOneWidget);
    });
    testWidgets('find ancestor widget of image ', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.ancestor(of:find.image( AssetImage('assets/images/splash.jpg')), matching:find.byType(Container)),findsOneWidget);
    });
    testWidgets('find descendant image of widget ', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.descendant(of:find.byType(Container), matching:find.image( AssetImage('assets/images/splash.jpg'))),findsOneWidget);
    });
    testWidgets('find widget with icon ', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.widgetWithIcon(FloatingActionButton, Icons.add),findsOneWidget);
    });
    testWidgets('find widget predicate ', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
       expect(find.byWidgetPredicate(
        (Widget widget) => widget is Tooltip && widget.message == 'Increment',
        description: 'widget with tooltip "Back"',
       ), findsOneWidget);
    });

  });
  }
