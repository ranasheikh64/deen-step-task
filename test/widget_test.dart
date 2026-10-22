import 'package:deen_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders placeholder text', (tester) async {
    await tester.pumpWidget(const DeenApp());
    expect(find.text('Deen App Skeleton Ready'), findsOneWidget);
  });
}
