import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

class SecretScreen extends StatelessWidget {
  final List<int> secret;
  const SecretScreen({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Secret')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('secret (hex): ${hex.encode(secret)}'),
          ],
        ));
  }
}
