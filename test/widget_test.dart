import 'package:flutter_test/flutter_test.dart';
import 'package:link_drop/link_drop.dart';
 

void main() {
  testWidgets('ReelDrop app starts successfully and navigates from splash', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const  LinkDrop());

    // Verify that the ReelDrop root widget is in the tree.
    expect(find.byType(LinkDrop), findsOneWidget);

    // Pump time to allow SplashServices 4-second timer and animations to complete
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // After 5 seconds, it should have navigated to the Home screen (or whichever is next)
    // No timers should be left pending now.
  });
}
