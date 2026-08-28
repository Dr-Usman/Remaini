import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remaini/data/models/time_remaining.dart';
import 'package:remaini/presentation/widgets/common/urgency_badge.dart';
import 'package:remaini/presentation/widgets/detail/time_unit_card.dart';

void main() {
  testWidgets('UrgencyBadge renders label and color correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: UrgencyBadge(urgency: UrgencyLevel.near)),
      ),
    );

    expect(find.text('Soon'), findsOneWidget);
  });

  testWidgets('TimeUnitCard renders values and unit labels', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: TimeUnitCard(value: 42, label: 'Days')),
      ),
    );

    expect(find.text('42'), findsOneWidget);
    expect(find.text('DAYS'), findsOneWidget);
  });
}
