import 'package:flutter/material.dart';
import 'package:subterfuge/screen/create_secret.dart';
import 'package:subterfuge/screen/recover_secret.dart';
import 'package:subterfuge/widget/disclaimer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Subterfuge, a secret sharing experience')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DisclaimerWidget(),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateSecretScreen()),
                );
              },
              child: const Text('Share a secret'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RecoverSecretScreen()),
                );
              },
              child: const Text('Recover a secret'),
            ),
          ],
        ));
  }
}
