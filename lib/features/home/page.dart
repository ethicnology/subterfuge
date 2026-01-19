import 'package:flutter/material.dart';
import 'package:subterfuge/features/import_mnemonic/page.dart';
import 'package:subterfuge/features/merge_shares/page.dart';
import 'package:subterfuge/features/home/support_widget.dart';
import 'package:subterfuge/features/home/disclaimer_banner.dart';

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
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SelectableText.rich(
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
                    ),
                    SizedBox(height: 50),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImportMnemonicPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Share mnemonic'),
                    ),
                    const SizedBox(height: 50),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MergeSharesPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.merge_type_rounded),
                      label: const Text('Recover mnemonic'),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, bottom: 50),
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
