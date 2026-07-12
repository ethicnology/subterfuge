import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subterfuge/features/import_mnemonic/mnemonic_widget.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  // Deterministic, well-known valid 12-word BIP-39 mnemonic derived from
  // all-zero entropy: "abandon abandon abandon abandon abandon abandon
  // abandon abandon abandon abandon abandon about". Using a real mnemonic
  // (rather than arbitrary valid words) lets the "last word submits" test
  // also assert the form actually parsed to a valid [bip39.Mnemonic].
  final validWords = bip39.Mnemonic(
    List<int>.filled(16, 0),
    bip39.Language.english,
  ).words;

  group('MnemonicWord fluidity', () {
    testWidgets(
      'completing the LAST word submits the form instead of silently '
      'doing nothing — regression test for the bug where this instead '
      'rescheduled a frame forever and pinned the UI thread at 100% CPU '
      '(see git history on mnemonic_widget.dart)',
      (tester) async {
        bip39.Mnemonic? submitted;
        await tester.pumpWidget(
          _wrap(
            MnemonicWidget(
              allowLanguageSelection: false,
              allowLengthSelection: false,
              allowPassphrase: false,
              onSubmit: (m) => submitted = m,
            ),
          ),
        );

        final fields = find.byType(TextField);
        // Every BIP-39 word is uniquely identified by its first 4
        // characters (a documented property of the wordlist), so typing
        // just that much is enough to trigger auto-fill — typing the full
        // word instead would already be "resolved" the instant it's
        // entered, never exercising the auto-fill path at all.
        for (var i = 0; i < validWords.length - 1; i++) {
          await tester.enterText(fields.at(i), validWords[i].substring(0, 4));
          await tester.pumpAndSettle();
        }

        // The last word's auto-fill — being the last field, with no next
        // field to advance focus to — must submit the form instead of
        // rescheduling a frame forever.
        await tester.enterText(fields.last, validWords.last.substring(0, 4));

        // If the bug regresses, this hangs/throws instead of settling.
        await tester.pumpAndSettle();

        expect(submitted, isNotNull);
        expect(submitted!.words, validWords);
      },
    );

    testWidgets(
      'auto-fill on a non-last word advances focus to the next field',
      (tester) async {
        await tester.pumpWidget(
          _wrap(
            MnemonicWidget(
              allowLanguageSelection: false,
              allowLengthSelection: false,
              allowPassphrase: false,
              onSubmit: (_) {},
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextField).first,
          validWords[0].substring(0, 4),
        );
        await tester.pumpAndSettle();

        final firstField = tester.widget<TextField>(
          find.byType(TextField).first,
        );
        final secondField = tester.widget<TextField>(
          find.byType(TextField).at(1),
        );
        expect(firstField.controller!.text, validWords[0]);
        expect(secondField.focusNode!.hasFocus, isTrue);
      },
    );

    testWidgets(
      'pressing the keyboard action on the last word submits the form, '
      'even without relying on auto-fill (e.g. auto-fill disabled, or the '
      'word was already complete when the action button is pressed)',
      (tester) async {
        bip39.Mnemonic? submitted;
        await tester.pumpWidget(
          _wrap(
            MnemonicWidget(
              allowLanguageSelection: false,
              allowLengthSelection: false,
              allowPassphrase: false,
              allowAutoFillWords: false,
              onSubmit: (m) => submitted = m,
            ),
          ),
        );

        final fields = find.byType(TextField);
        for (var i = 0; i < validWords.length; i++) {
          await tester.enterText(fields.at(i), validWords[i]);
          await tester.pump();
        }

        // Simulates pressing the IME's "Done" action button on the last
        // field — this must reach the same `onEditingComplete` callback as
        // auto-fill does.
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(submitted, isNotNull);
        expect(submitted!.words, validWords);
      },
    );

    testWidgets(
      'Backspace on an already-empty field moves focus to the previous '
      'one, without touching its content',
      (tester) async {
        await tester.pumpWidget(
          _wrap(
            MnemonicWidget(
              allowLanguageSelection: false,
              allowLengthSelection: false,
              allowPassphrase: false,
              // Ambiguous prefix below never auto-fills regardless, but
              // disabling this keeps the test focused on manual navigation.
              allowAutoFillWords: false,
              onSubmit: (_) {},
            ),
          ),
        );

        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), 'ab');
        await tester.pump();
        await tester.tap(fields.at(1));
        await tester.pump();

        expect(
          tester.widget<TextField>(fields.at(1)).focusNode!.hasFocus,
          isTrue,
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
        await tester.pump();

        expect(
          tester.widget<TextField>(fields.at(0)).focusNode!.hasFocus,
          isTrue,
        );
        // Jumping back doesn't clobber field 0's own content.
        expect(find.text('ab'), findsOneWidget);
      },
    );

    testWidgets(
      'Backspace with text still present deletes a character normally — '
      'the global key listener backing the previous-field jump must never '
      'swallow real editing',
      (tester) async {
        await tester.pumpWidget(
          _wrap(
            MnemonicWidget(
              allowLanguageSelection: false,
              allowLengthSelection: false,
              allowPassphrase: false,
              allowAutoFillWords: false,
              onSubmit: (_) {},
            ),
          ),
        );

        await tester.enterText(find.byType(TextField).first, 'aban');
        await tester.pump();

        await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
        await tester.pump();

        expect(find.text('aba'), findsOneWidget);
      },
    );

    testWidgets(
      'shows inline suggestions only for the focused field, and hides '
      'them again once focus moves to another field',
      (tester) async {
        await tester.pumpWidget(
          _wrap(
            MnemonicWidget(
              allowLanguageSelection: false,
              allowLengthSelection: false,
              allowPassphrase: false,
              allowAutoFillWords: false,
              onSubmit: (_) {},
            ),
          ),
        );

        final fields = find.byType(TextField);
        await tester.enterText(fields.at(0), 'ab');
        await tester.pump();

        expect(find.text('abandon'), findsOneWidget);

        await tester.tap(fields.at(1));
        await tester.pump();

        // Field 0's suggestions disappear once it's no longer focused,
        // even though its text is still the ambiguous 'ab'.
        expect(find.text('abandon'), findsNothing);
      },
    );
  });
}
