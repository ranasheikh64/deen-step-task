import 'package:deen_app/features/home/presentation/widgets/enable_location_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EnableLocationDialog renders content and handles tap', (
    tester,
  ) async {
    var wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EnableLocationDialog(
            onTurnOnLocation: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    // Verify title and description
    expect(find.text('Enable Location'), findsOneWidget);
    expect(find.text('Turn On Location'), findsOneWidget);
    expect(find.textContaining('We need to access'), findsOneWidget);

    // Tap button
    await tester.tap(find.text('Turn On Location'));
    await tester.pumpAndSettle();

    expect(wasTapped, isTrue);
  });
}
