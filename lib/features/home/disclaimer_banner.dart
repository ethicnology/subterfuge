import 'package:flutter/material.dart';
import 'package:subterfuge/shared/info_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class DisclaimerBanner extends StatelessWidget {
  const DisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InfoBanner(
        severity: InfoBannerSeverity.warning,
        icon: Icons.pan_tool_rounded,
        content: const Text(
          "Don't trust, verify",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        action: OutlinedButton(
          onPressed: () {
            launchUrl(Uri.parse('https://github.com/ethicnology/subterfuge'));
          },
          child: const Text('VERIFY'),
        ),
      ),
    );
  }
}
