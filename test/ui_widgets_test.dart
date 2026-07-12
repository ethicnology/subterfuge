import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subterfuge/shared/numbered_words_view.dart';
import 'package:subterfuge/shared/number_stepper_field.dart';
import 'package:subterfuge/shared/revealable_secret.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('NumberedWordsView', () {
    testWidgets('numbers every word starting at 01, split into two columns', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(const NumberedWordsView(text: 'alpha bravo charlie delta echo')),
      );

      expect(find.text('01'), findsOneWidget);
      expect(find.text('05'), findsOneWidget);
      expect(find.text('alpha'), findsOneWidget);
      expect(find.text('echo'), findsOneWidget);
      // 5 words -> ceil(5/2) = 3 on the left, 2 on the right.
      expect(find.text('03'), findsOneWidget);
      expect(find.text('charlie'), findsOneWidget);
    });

    testWidgets('collapses extra whitespace between words', (tester) async {
      await tester.pumpWidget(
        _wrap(const NumberedWordsView(text: '  one   two\nthree  ')),
      );

      expect(find.text('one'), findsOneWidget);
      expect(find.text('two'), findsOneWidget);
      expect(find.text('three'), findsOneWidget);
      expect(find.text('03'), findsOneWidget);
    });
  });

  group('RevealableSecret', () {
    testWidgets(
      'starts blurred with a reveal hint, then shows content on tap',
      (tester) async {
        await tester.pumpWidget(
          _wrap(const RevealableSecret(child: Text('top-secret-content'))),
        );

        expect(find.text('Tap to reveal'), findsOneWidget);

        // The reveal hint sits under an opaque GestureDetector by design
        // (tapping anywhere over the blur reveals it, not just the label),
        // so flutter_test's hit-test sanity check on the label itself is
        // expected to be a near-miss here.
        await tester.tap(find.text('Tap to reveal'), warnIfMissed: false);
        await tester.pump();

        expect(find.text('Tap to reveal'), findsNothing);
        expect(find.byIcon(Icons.visibility_off_rounded), findsOneWidget);
      },
    );

    testWidgets('initiallyRevealed skips the blur entirely', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const RevealableSecret(
            initiallyRevealed: true,
            child: Text('already-visible'),
          ),
        ),
      );

      expect(find.text('Tap to reveal'), findsNothing);
      expect(find.byIcon(Icons.visibility_off_rounded), findsOneWidget);
    });
  });

  group('NumberStepperField', () {
    testWidgets(
      'increments/decrements within min/max and reports via onChanged',
      (tester) async {
        int? lastValue;
        await tester.pumpWidget(
          _wrap(
            NumberStepperField(
              label: 'Count',
              min: 1,
              max: 3,
              initialValue: 2,
              onChanged: (v) => lastValue = v,
            ),
          ),
        );

        expect(find.text('2'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add_rounded));
        await tester.pump();
        expect(find.text('3'), findsOneWidget);
        expect(lastValue, 3);

        // Already at max: the `+` button must now be disabled (no-op).
        await tester.tap(find.byIcon(Icons.add_rounded));
        await tester.pump();
        expect(find.text('3'), findsOneWidget);
        expect(lastValue, 3);

        await tester.tap(find.byIcon(Icons.remove_rounded));
        await tester.pump();
        await tester.tap(find.byIcon(Icons.remove_rounded));
        await tester.pump();
        expect(find.text('1'), findsOneWidget);
        expect(lastValue, 1);

        // Already at min: the `-` button must now be disabled (no-op).
        await tester.tap(find.byIcon(Icons.remove_rounded));
        await tester.pump();
        expect(find.text('1'), findsOneWidget);
        expect(lastValue, 1);
      },
    );

    testWidgets('surfaces validator errors', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Form(
            child: NumberStepperField(
              label: 'Threshold',
              min: 1,
              max: 16,
              initialValue: 5,
              validator: (v) => (v != null && v > 3) ? 'Too high' : null,
            ),
          ),
        ),
      );

      final formState = tester.state<FormState>(find.byType(Form));
      expect(formState.validate(), isFalse);
      await tester.pump();

      expect(find.text('Too high'), findsOneWidget);
    });
  });
}
