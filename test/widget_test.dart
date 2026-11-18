import 'package:flutter_test/flutter_test.dart';
import 'package:calendrier/main.dart';

void main() {
  testWidgets('Calendrier App smoke test', (WidgetTester tester) async {
    // Build app frame
    await tester.pumpWidget(const DiliPrestigeCalendarApp());

    // Verify title text is present
    expect(find.text('DILI PRESTIGE'), findsOneWidget);
  });
}
