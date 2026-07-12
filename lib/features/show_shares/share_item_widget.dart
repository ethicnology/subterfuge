import 'package:flutter/material.dart';
import 'package:subterfuge/shared/numbered_words_view.dart';
import 'package:subterfuge/shared/revealable_secret.dart';
import 'package:subterfuge/shared/secure_clipboard.dart';

class ShareItemWidget extends StatelessWidget {
  final String share;
  const ShareItemWidget({super.key, required this.share});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            // Each word is numbered (01, 02, …), matching the same
            // convention used when *entering* a mnemonic: a single
            // mistranscribed word can make this whole share useless when
            // copied onto paper, so keeping track of position matters.
            // Starts blurred (RevealableSecret) as a shoulder-surfing
            // mitigation while writing it down.
            child: RevealableSecret(
              borderRadius: borderRadius,
              child: NumberedWordsView(text: share),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: OutlinedButton.icon(
              onPressed: () => copySensitiveToClipboard(
                context,
                label: 'Share',
                content: share,
              ),
              icon: const Icon(Icons.copy_rounded),
              label: const Text('Copy Share'),
            ),
          ),
        ],
      ),
    );
  }
}
