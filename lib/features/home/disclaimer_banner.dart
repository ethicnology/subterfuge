import 'package:flutter/material.dart';
import 'package:subterfuge/features/disclaimer/page.dart';

class DisclaimerBanner extends StatelessWidget {
  const DisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      padding: const EdgeInsets.all(20),
      content: const Text(
        'Prototype: Use it at your own risk.',
        style: TextStyle(color: Colors.black),
      ),
      leading: const Icon(Icons.pan_tool, color: Colors.redAccent),
      backgroundColor: Colors.tealAccent,
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DisclaimerPage()),
            );
          },
          child: const Text('MORE'),
        ),
      ],
    );
  }
}
