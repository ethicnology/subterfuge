import 'package:flutter/material.dart';
import 'package:subterfuge/widget/share.dart';

class GroupWidget extends StatelessWidget {
  String number;
  List<String> shares;
  GroupWidget({super.key, required this.number, required this.shares});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.teal,
        child: Column(
          children: [
            Text('Group $number:'),
            for (int i = 0; i < shares.length; i++)
              ShareWidget(number: '${i + 1}', share: shares[i])
          ],
        ));
  }
}
