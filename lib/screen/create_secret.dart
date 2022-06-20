import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:slip39/slip39.dart';
import 'package:subterfuge/screen/shares.dart';

class CreateSecretScreen extends StatefulWidget {
  const CreateSecretScreen({super.key});

  @override
  State<CreateSecretScreen> createState() => _CreateSecretScreenState();
}

class _CreateSecretScreenState extends State<CreateSecretScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hasPassphrase = false;
  TextEditingController secret = TextEditingController();
  TextEditingController passphrase = TextEditingController();
  TextEditingController groups = TextEditingController();
  TextEditingController threshold = TextEditingController();

  @override
  void dispose() {
    passphrase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create Shared Secret')),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: secret,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Master Secret',
                ),
              ),
              SwitchListTile(
                  title: const Text('Passphrase ?'),
                  value: hasPassphrase,
                  onChanged: (bool value) {
                    setState(() {
                      hasPassphrase = value;
                    });
                  }),
              if (hasPassphrase)
                TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passphrase,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.password), labelText: 'Passphrase'),
                ),
              TextFormField(
                controller: groups,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Groups',
                ),
              ),
              TextFormField(
                controller: threshold,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Threshold',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SharesScreen(
                              slip: Slip39.from([
                                [1, 1],
                                [1, 1],
                                [1, 1]
                              ],
                                  masterSecret:
                                      Uint8List.fromList(secret.text.codeUnits),
                                  passphrase: passphrase.text,
                                  threshold: int.parse(threshold.text)),
                            )),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ));
  }
}
