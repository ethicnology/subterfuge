import 'package:flutter/material.dart';
import 'package:subterfuge/features/combine_shares/page.dart';
import 'package:subterfuge/features/import_mnemonic/page.dart';
import 'package:subterfuge/features/share_secret/page.dart';
import 'package:subterfuge/features/home/disclaimer_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Subterfuge, a secret sharing experience')),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DisclaimerBanner(),
            const Divider(),
            const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 25, left: 10, right: 10),
                child: SelectableText.rich(
                  TextSpan(text: '', children: [
                    TextSpan(
                      text: 'subterfuge',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            ': An indirect or deceptive device or stratagem. Refers especially to war and diplomatics.'),
                  ]),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShareSecretPage()),
                    );
                  },
                  child: const Text('Share a seed'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CombineSharesPage()),
                    );
                  },
                  child: const Text('Assemble a seed'),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImportMnemonicPage()),
                    );
                  },
                  child: const Text('Share a mnemonic'),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const SizedBox(
              width: 525,
              child: SelectableText(
                'Adi Shamir published How to Share a Secret in november 1979.\nDecades later, with the boom of cryptocurrencies, Shamir secret sharing resurface.\nHow to deal with private keys belonging to a group instead of individual such as non-profit organizations and companies…\nIn his scientific publication Shamir presents a threshold schemes ideally suited to applications in which a group of mutually suspicious individuals with conflicting interests must cooperate. Ideally we would like the cooperation to be based on mutual consent.\nSatoshi Lab Improvement Proposal n°39 or SLIP39 is the document that formalize Shamir’s Secret Sharing for Mnemonic Codes, a group of easy to remember words which are widespread to backup secret keys.\nThis application is an attempt to implement SLIP39 in Flutter, an open source framework by Google for building natively compiled, multi-platform (Linux, Web, Android, Windows, MacOs, iOs) applications from a single codebase.',
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 50),
            const SelectableText('github.com/ethicnology/subterfuge',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        )));
  }
}
