import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareItemWidget extends StatelessWidget {
  final String share;
  const ShareItemWidget({super.key, required this.share});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SelectableText(
            share,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
            ),
            showCursor: false,
            contextMenuBuilder: (context, editableTextState) {
              return AdaptiveTextSelectionToolbar.editableText(
                editableTextState: editableTextState,
              );
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: share));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Share copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: const Icon(Icons.copy_rounded),
            label: const Text('Copy Share'),
          ),
        ],
      ),
    );
  }
}
