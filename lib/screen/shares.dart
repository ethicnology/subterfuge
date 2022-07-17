import 'package:flutter/material.dart';
import 'package:slip39/slip39.dart';
import 'package:subterfuge/widget/group.dart';

class SharesScreen extends StatelessWidget {
  final Slip39 slip;
  const SharesScreen({super.key, required this.slip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Shares')),
        body: ListView(
            shrinkWrap: true,
            children: List.generate(slip.groupCount, (group) {
              return GroupWidget(
                  number: '${group + 1}',
                  shares: slip.fromPath('r/$group').mnemonics);
            })));
  }
}
