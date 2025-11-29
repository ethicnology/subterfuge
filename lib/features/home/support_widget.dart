import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportDeveloperWidget extends StatelessWidget {
  const SupportDeveloperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Support Development',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'This app is built and maintained on my free time. Your support helps keep it alive and growing.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://github.com/ethicnology/subterfuge'),
                      );
                    },
                    icon: const Icon(Icons.star_rounded),
                    label: const Text('Star on GitHub'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://github.com/sponsors/ethicnology'),
                      );
                    },
                    icon: const Icon(Icons.volunteer_activism_rounded),
                    label: const Text('Sponsor'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
