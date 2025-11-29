import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowSecretPage extends StatelessWidget {
  final Uint8List secret;
  const ShowSecretPage({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secret')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_open_rounded,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.key_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Your Secret',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SelectableText(
                          hex.encode(secret),
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: hex.encode(secret)),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Secret copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.copy_rounded),
                        label: const Text('Copy Secret'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
