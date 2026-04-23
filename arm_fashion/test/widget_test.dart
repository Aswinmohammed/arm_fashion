import 'package:flutter_test/flutter_test.dart';

import 'package:arm_fashion/main.dart';

void main() {
  testWidgets('shows the login entry screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ArmFashionApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('SIGN IN TO YOUR ACCOUNT'), findsOneWidget);
  });
}
