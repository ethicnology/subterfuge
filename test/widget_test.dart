import 'package:flutter_test/flutter_test.dart';
import 'package:subterfuge/main.dart';

void main() {
  testWidgets('App boots and shows the home page entry points', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Subterfuge, a secret sharing experience'),
      findsOneWidget,
    );
    expect(find.text('Share mnemonic'), findsOneWidget);
    expect(find.text('Recover mnemonic'), findsOneWidget);
  });
}
