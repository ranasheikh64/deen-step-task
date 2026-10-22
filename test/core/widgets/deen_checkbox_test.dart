import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/widgets/deen_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeenCheckbox Tests', () {
    testWidgets('renders white box with no checkmark when value is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DeenCheckbox(value: false, onChanged: (_) {})),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, equals(AppColors.checkboxWhite));
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('renders dark checkmark when value is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DeenCheckbox(value: true, onChanged: (_) {})),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      final icon = tester.widget<Icon>(find.byIcon(Icons.check));
      expect(icon.color, equals(AppColors.checkboxCheckmark));
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      var toggled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeenCheckbox(value: false, onChanged: (val) => toggled = val),
          ),
        ),
      );

      await tester.tap(find.byType(DeenCheckbox));
      await tester.pumpAndSettle();

      expect(toggled, isTrue);
    });
  });
}
