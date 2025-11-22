import 'package:flutter/material.dart';
import 'package:subterfuge/features/disclaimer/page.dart';

class DisclaimerBanner extends StatelessWidget {
  const DisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      padding: const EdgeInsets.all(20),
      content: const Text('Experimental Prototype: Use it at your own risk.'),
      leading: const Icon(Icons.pan_tool),
      backgroundColor: Colors.red,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DisclaimerPage()),
            );
          },
          child: const Text('READ'),
        ),
      ],
    );
  }
}
