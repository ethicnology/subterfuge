import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subterfuge/features/import_mnemonic/page.dart';
import 'package:subterfuge/features/merge_shares/page.dart';
import 'package:subterfuge/features/share_secret/page.dart';
import 'package:subterfuge/features/show_secret/page.dart';
import 'package:subterfuge/features/show_shares/page.dart';

Widget _app(Widget child) => MaterialApp(home: child);

void main() {
  group('ShareSecretPage', () {
    testWidgets('shows sensible defaults (3 participants, 2 threshold) and '
        'the mnemonic-extraction hint when no secret was pre-filled', (
      tester,
    ) async {
      await tester.pumpWidget(_app(const ShareSecretPage()));
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget); // Participants stepper
      expect(find.text('2'), findsOneWidget); // Threshold stepper
      expect(find.textContaining('Extract the entropy first'), findsOneWidget);
    });

    testWidgets('hides the mnemonic hint and locks the field when a secret '
        'is pre-filled (coming from Import Mnemonic)', (tester) async {
      await tester.pumpWidget(
        _app(const ShareSecretPage(secret: '00112233445566778899aabbccddeeff')),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Extract the entropy first'), findsNothing);
      expect(find.text('00112233445566778899aabbccddeeff'), findsOneWidget);
    });

    testWidgets('rejects a threshold greater than participants', (
      tester,
    ) async {
      await tester.pumpWidget(_app(const ShareSecretPage()));
      await tester.pumpAndSettle();

      // Push threshold from 2 up to 4, participants stays at 3.
      final incrementButtons = find.byIcon(Icons.add_rounded);
      await tester.tap(incrementButtons.last);
      await tester.pump();
      await tester.tap(incrementButtons.last);
      await tester.pump();

      await tester.ensureVisible(find.text('Submit'));
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.textContaining('Cannot exceed participants'), findsOneWidget);
    });
  });

  group('MergeSharesPage', () {
    testWidgets('starts with 2 ready-to-paste share fields', (tester) async {
      await tester.pumpWidget(_app(const MergeSharesPage()));
      await tester.pumpAndSettle();

      expect(find.text('shares 1'), findsOneWidget);
      expect(find.text('shares 2'), findsOneWidget);
      expect(find.text('shares 3'), findsNothing);
    });

    testWidgets('stepping the share count adds another input field', (
      tester,
    ) async {
      await tester.pumpWidget(_app(const MergeSharesPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pumpAndSettle();

      expect(find.text('shares 3'), findsOneWidget);
    });
  });

  group('ShowSharesPage', () {
    testWidgets('renders each share as a blurred, numbered word grid', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const ShowSharesPage(
            shares: ['alpha bravo charlie delta', 'echo foxtrot golf hotel'],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Participant 1'), findsOneWidget);
      expect(find.text('Participant 2'), findsOneWidget);
      // Blurred by default: the words are present in the tree (for the
      // Copy button / accessibility) but the reveal hint is shown instead
      // of being immediately legible.
      expect(find.text('Tap to reveal'), findsNWidgets(2));

      await tester.tap(find.text('Tap to reveal').first, warnIfMissed: false);
      await tester.pump();

      expect(find.text('alpha'), findsOneWidget);
    });
  });

  group('ImportMnemonicPage', () {
    testWidgets(
      'renders the numbered word grid with the redundant validity icon '
      '(color-blind-safe cue, not just green/red)',
      (tester) async {
        await tester.pumpWidget(_app(const ImportMnemonicPage()));
        await tester.pumpAndSettle();

        expect(find.text('01'), findsOneWidget);
        expect(find.text('12'), findsOneWidget);

        await tester.enterText(find.byType(TextField).first, 'zoo');
        await tester.pump();

        expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      },
    );
  });

  group('ShowSecretPage', () {
    testWidgets('renders the passphrase-verification warning and a numbered '
        'mnemonic for entropy-length secrets', (tester) async {
      final entropy = Uint8List(16); // 128-bit -> BIP-39 entropy, not a seed.

      await tester.pumpWidget(_app(ShowSecretPage(secret: entropy)));
      await tester.pumpAndSettle();

      expect(find.textContaining('SLIP-39 silently returns'), findsOneWidget);
      expect(find.text('Entropy (128-256 bits)'), findsOneWidget);
      // The recovered mnemonic is blurred by default too.
      expect(find.text('Tap to reveal'), findsWidgets);
    });
  });
}
