import 'package:deen_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders onboarding with DEEN-STEP title', (tester) async {
    await tester.pumpWidget(const DeenApp());
    await tester.pumpAndSettle();
    expect(find.text('DEEN-STEP'), findsOneWidget);
  });
}
