import 'package:flutter_test/flutter_test.dart';

import 'package:video_poc/app/app.locator.dart';
import 'package:video_poc/main.dart';

void main() {
  testWidgets('Home shows call settings and start button', (
    WidgetTester tester,
  ) async {
    await setupLocator();
    await tester.pumpWidget(const VideoPocApp());

    expect(find.text('Call Settings'), findsOneWidget);
    expect(find.textContaining('Session:'), findsOneWidget);
    expect(find.text('User ID'), findsOneWidget);
    expect(find.text('Start Video Call'), findsOneWidget);
  });
}
