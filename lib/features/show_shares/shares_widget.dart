import 'package:flutter/material.dart';
import 'package:subterfuge/features/show_shares/share_item_widget.dart';

class SharesWidget extends StatelessWidget {
  final String number;
  final List<String> shares;
  const SharesWidget({super.key, required this.number, required this.shares});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.teal,
        child: Column(
          children: [
            Text(number),
            for (int i = 0; i < shares.length; i++)
              ShareItemWidget(number: '${i + 1}', share: shares[i])
          ],
        ));
  }
}
