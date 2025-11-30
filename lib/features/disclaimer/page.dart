import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dependencies')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Applications relies on dependencies. These dependencies may contain bugs or vulnerabilities that I\'m not responsible for because they are developed and maintained by third parties. Subterfuge relies on few dependencies that you can verify.',
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://github.com/ethicnology/subterfuge/blob/main/pubspec.yaml#L17',
                    ),
                  );
                },
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
