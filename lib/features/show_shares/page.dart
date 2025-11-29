import 'package:flutter/material.dart';
import 'package:subterfuge/features/show_shares/shares_widget.dart';

class ShowSharesPage extends StatelessWidget {
  final List<String> shares;

  const ShowSharesPage({super.key, required this.shares});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shares')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(
                Icons.share_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Distribute these shares securely',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(shares.length, (index) {
                return SharesWidget(
                  number: '${index + 1}',
                  shares: [shares[index]],
                );
              }),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Done'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
