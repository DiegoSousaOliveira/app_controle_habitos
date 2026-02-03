import 'package:flutter_test/flutter_test.dart';
import 'package:controle_habitos/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we start on login screen
    expect(find.byType(MyApp), findsOneWidget);
  });
}
