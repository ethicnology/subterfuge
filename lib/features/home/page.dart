import 'package:flutter/material.dart';
import 'package:subterfuge/features/import_mnemonic/page.dart';
import 'package:subterfuge/features/merge_shares/page.dart';
import 'package:subterfuge/features/home/support_widget.dart';
import 'package:subterfuge/features/home/disclaimer_banner.dart';
import 'package:subterfuge/shared/action_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subterfuge, a secret sharing experience'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const DisclaimerBanner(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // A concrete, one-line tagline first, so a
                          // first-time user immediately knows what this
                          // app does — the dictionary-definition branding
                          // below is evocative but doesn't explain that.
                          Text(
                            'Split any secret into shares. Recover it only '
                            'when enough of them are combined.',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 12),
                          const SelectableText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'subterfuge',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      ': An indirect or deceptive device or stratagem.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          ActionCard(
                            icon: Icons.call_split_rounded,
                            title: 'Share mnemonic',
                            subtitle:
                                'Split a mnemonic or secret into shares that '
                                'require a threshold of them to recover.',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ImportMnemonicPage(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ActionCard(
                            icon: Icons.restore_rounded,
                            title: 'Recover mnemonic',
                            subtitle:
                                'Combine previously created shares back '
                                'into the original secret.',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MergeSharesPage(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(top: 32, bottom: 32),
                      child: SupportDeveloperWidget(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
