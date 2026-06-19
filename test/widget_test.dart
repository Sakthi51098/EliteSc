import 'package:elite/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders splash placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(const EliteApp());

    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
