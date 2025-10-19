import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

class ShowSecretPage extends StatelessWidget {
  final Uint8List secret;
  const ShowSecretPage({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secret')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.teal)),
          child: SelectableText(hex.encode(secret)),
        ),
      ),
    );
  }
}
