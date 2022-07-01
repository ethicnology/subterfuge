import 'package:flutter/material.dart';
import 'package:subterfuge/screen/create_secret.dart';
import 'package:subterfuge/screen/recover_secret.dart';
import 'package:subterfuge/widget/disclaimer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Subterfuge')),
        body: Column(
          children: [
            const DisclaimerWidget(),
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
              child: const Text('Create Shared Secret'),
            ),
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
              child: const Text('Recover Shared Secret'),
            ),
          ],
        ));
  }
}
