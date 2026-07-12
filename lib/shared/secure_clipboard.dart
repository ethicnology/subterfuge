import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensitive_clipboard/sensitive_clipboard.dart';

/// Copies [content] to the system clipboard and best-effort clears it again
/// after [autoClearAfter].
///
/// The system clipboard is a shared, often-synced resource (e.g. Gboard/
/// Samsung cloud clipboard, Windows Clipboard History + "Sync across your
/// devices", any foreground app on Android, other apps polling
/// `NSPasteboard`/`XClipboard`). Copying a mnemonic, seed, or share to it is
/// convenient but leaves the secret reachable long after the user is done
/// pasting it. Two mitigations are combined:
/// - On Android 13+, `sensitive_clipboard` sets
///   `ClipDescription.EXTRA_IS_SENSITIVE` (falling back to the equivalent
///   OEM-compatible extra on API 24-32), which masks the content in the
///   system clipboard-preview popup and excludes it from cross-device
///   clipboard sync. On other platforms it just calls Flutter's standard
///   `Clipboard.setData`.
/// - Auto-clearing after [autoClearAfter] narrows the window during which
///   the secret sits in the clipboard on every platform.
///
/// This remains a best-effort mitigation: it cannot prevent something else
/// from reading the clipboard *during* the [autoClearAfter] window, and it
/// only clears the clipboard if it still contains exactly [content] when the
/// timer fires, so it never clobbers something the user copied elsewhere in
/// the meantime.
Future<void> copySensitiveToClipboard(
  BuildContext context, {
  required String label,
  required String content,
  Duration autoClearAfter = const Duration(seconds: 45),
}) async {
  final hidden = await SensitiveClipboard.copy(content);

  Future.delayed(autoClearAfter, () async {
    final current = await Clipboard.getData(Clipboard.kTextPlain);
    if (current?.text == content) {
      await Clipboard.setData(const ClipboardData(text: ''));
    }
  });

  // On Android 13+, the OS itself already shows a "Copied" popup for
  // sensitive clips (and recommends apps suppress their own feedback to
  // avoid a duplicate notification), so only show our snackbar otherwise.
  if (!hidden && context.mounted) {
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
