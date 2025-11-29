import 'package:flutter/material.dart';
import 'package:subterfuge/features/combine_shares/page.dart';
import 'package:subterfuge/features/home/support_widget.dart';
import 'package:subterfuge/features/share_secret/page.dart';
import 'package:subterfuge/features/home/disclaimer_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subterfuge, a secret sharing experience'),
      ),
      body: SingleChildScrollView(
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
                          ': An indirect or deceptive device or stratagem. Refers especially to war and diplomatics.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShareSecretPage(),
                        ),
                      );
                    },
                    child: const Text('Share'),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CombineSharesPage(),
                        ),
                      );
                    },
                    child: const Text('Merge'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SupportDeveloperWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
