import 'dart:typed_data';

import 'package:convert/convert.dart';
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
  TextEditingController shares = TextEditingController();
  TextEditingController threshold = TextEditingController();

  @override
  void dispose() {
    secret.dispose();
    passphrase.dispose();
    shares.dispose();
    threshold.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create Shared Secret')),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                  color: Colors.teal,
                  child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: TextFormField(
                        controller: secret,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Master Secret',
                        ),
                      ))),
              Card(
                  color: Colors.teal,
                  child: Column(children: [
                    SwitchListTile(
                        title: const Text('Passphrase ?'),
                        value: hasPassphrase,
                        onChanged: (bool value) {
                          setState(() {
                            hasPassphrase = value;
                          });
                        }),
                    if (hasPassphrase)
                      Padding(
                          padding: const EdgeInsets.all(7),
                          child: TextFormField(
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passphrase,
                            decoration:
                                const InputDecoration(labelText: 'Passphrase'),
                          )),
                  ])),
              Card(
                  color: Colors.teal,
                  child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextFormField(
                                    controller: shares,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Shares',
                                    ),
                                  ))),
                          Flexible(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextFormField(
                                    controller: threshold,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Threshold',
                                    ),
                                  ))),
                        ],
                      ))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.teal,
                ),
                onPressed: () {
                  List<List<int>> scheme = [
                    for (var i = 0; i < int.parse(shares.text); i++) [1, 1]
                  ];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SharesScreen(
                              slip: Slip39.from(scheme,
                                  masterSecret: Uint8List.fromList(
                                      hex.decode(secret.text)),
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
