import 'package:flutter/material.dart';

class ShareItemWidget extends StatelessWidget {
  final String number;
  final String share;
  const ShareItemWidget({super.key, required this.number, required this.share});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.teal,
        child: Column(
          children: [
            SelectableText(
              share,
              showCursor: true,
              contextMenuBuilder: (context, editableTextState) {
                return AdaptiveTextSelectionToolbar.editableText(
                  editableTextState: editableTextState,
                );
              },
            )
          ],
        ));
  }
}
