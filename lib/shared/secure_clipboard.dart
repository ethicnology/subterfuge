import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Copies [content] to the system clipboard and best-effort clears it again
/// after [autoClearAfter].
///
/// The system clipboard is a shared, often-synced resource (e.g. Gboard/
/// Samsung cloud clipboard, Windows Clipboard History + "Sync across your
/// devices", any foreground app on Android, other apps polling
/// `NSPasteboard`/`XClipboard`). Copying a mnemonic, seed, or share to it is
/// convenient but leaves the secret reachable long after the user is done
/// pasting it. Auto-clearing narrows that exposure window.
///
/// This is a best-effort mitigation only:
/// - It cannot prevent something else from reading the clipboard *during*
///   the [autoClearAfter] window.
/// - It only clears the clipboard if it still contains exactly [content]
///   when the timer fires, so it never clobbers something the user copied
///   elsewhere in the meantime.
/// - Dart/Flutter offer no cross-platform API to mark clipboard content as
///   "sensitive" (e.g. Android 13+ `ClipDescription.EXTRA_IS_SENSITIVE`,
///   which masks the system clipboard-preview UI and excludes it from
///   cloud sync); that would require a platform channel per OS and is left
///   as a possible follow-up.
Future<void> copySensitiveToClipboard(
  BuildContext context, {
  required String label,
  required String content,
  Duration autoClearAfter = const Duration(seconds: 45),
}) async {
  await Clipboard.setData(ClipboardData(text: content));

  Future.delayed(autoClearAfter, () async {
    final current = await Clipboard.getData(Clipboard.kTextPlain);
    if (current?.text == content) {
      await Clipboard.setData(const ClipboardData(text: ''));
    }
  });

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$label copied to clipboard '
          '(cleared automatically in ${autoClearAfter.inSeconds}s)',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
