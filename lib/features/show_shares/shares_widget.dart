import 'package:flutter/material.dart';
import 'package:subterfuge/features/show_shares/share_item_widget.dart';

class SharesWidget extends StatelessWidget {
  final String number;
  final List<String> shares;
  const SharesWidget({super.key, required this.number, required this.shares});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Participant $number',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < shares.length; i++)
              ShareItemWidget(share: shares[i]),
          ],
        ),
      ),
    );
  }
}
