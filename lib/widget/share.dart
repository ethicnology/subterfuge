import 'package:flutter/material.dart';

class ShareWidget extends StatelessWidget {
  final String number;
  final String share;
  const ShareWidget({super.key, required this.number, required this.share});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.teal,
        child: Column(
          children: [
            Text('Share $number: '),
            SelectableText(share,
                showCursor: true,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  selectAll: true,
                  cut: false,
                  paste: false,
                ))
          ],
        ));
  }
}
