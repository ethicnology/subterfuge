import 'package:flutter/material.dart';
import 'package:subterfuge/features/show_shares/share_item_widget.dart';

class SharesWidget extends StatelessWidget {
  final String number;
  final List<String> shares;
  const SharesWidget({super.key, required this.number, required this.shares});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('Participant $number'),
            for (int i = 0; i < shares.length; i++)
              ShareItemWidget(share: shares[i]),
          ],
        ),
      ),
    );
  }
}
