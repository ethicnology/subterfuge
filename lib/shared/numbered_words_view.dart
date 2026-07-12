import 'package:flutter/material.dart';

/// Displays a mnemonic/share as a numbered 2-column grid of words, matching
/// the numbered-index style already used when *entering* a mnemonic (see
/// [MnemonicWord] in `import_mnemonic/mnemonic_widget.dart`).
///
/// A mistranscribed word in a share or a recovered mnemonic can make an
/// entire backup unusable, and a single unnumbered flowing paragraph of
/// 20-59 words (the previous rendering) makes it easy to lose track of
/// position while copying it onto paper. Numbering each word is the single
/// highest-value change for this class of app.
class NumberedWordsView extends StatelessWidget {
  final String text;

  const NumberedWordsView({super.key, required this.text});

  List<String> get _words =>
      text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    final words = _words;
    if (words.isEmpty) return const SizedBox.shrink();

    final splitIndex = (words.length / 2).ceil();
    final left = words.sublist(0, splitIndex);
    final right = words.sublist(splitIndex);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              for (var i = 0; i < left.length; i++)
                _WordCell(index: i, word: left[i]),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              for (var i = 0; i < right.length; i++)
                _WordCell(index: splitIndex + i, word: right[i]),
            ],
          ),
        ),
      ],
    );
  }
}

class _WordCell extends StatelessWidget {
  final int index;
  final String word;

  const _WordCell({required this.index, required this.word});

  String get _displayIndex {
    final n = index + 1;
    return n < 10 ? '0$n' : '$n';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _displayIndex,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              word,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
