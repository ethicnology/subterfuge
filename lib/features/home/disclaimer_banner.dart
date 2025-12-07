import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisclaimerBanner extends StatelessWidget {
  const DisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      padding: const EdgeInsets.all(20),
      content: const Text(
        'Dont trust, verify',
        style: TextStyle(color: Colors.black),
      ),
      leading: const Icon(Icons.pan_tool, color: Colors.redAccent),
      backgroundColor: Colors.tealAccent,
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            launchUrl(Uri.parse('https://github.com/ethicnology/subterfuge'));
          },
          child: const Text('VERIFY'),
        ),
      ],
    );
  }
}
