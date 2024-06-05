import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:slip39/slip39.dart';
import 'package:subterfuge/screen/disclaimer.dart';
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
  var random = Random.secure();

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
        appBar: AppBar(title: const Text('Share a secret')),
        body: Form(
            key: _formKey,
            child: Center(
                child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 3),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal, backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          var randomValues = List<int>.generate(
                              32, (i) => random.nextInt(256));
                          setState(() {
                            secret.text = hex.encode(randomValues);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              'You should read the disclaimer about randomness',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: 'READ',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DisclaimerScreen()),
                                );
                              },
                            ),
                          ));
                        },
                        child: const Text('Generate Random Secret (256bits)'),
                      )),
                  Card(
                      color: Colors.teal,
                      child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: TextFormField(
                            controller: secret,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'eg. 0123456789abcdef0123456789ABCDEF',
                              labelText: 'Secret',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill the secret with a hexadecimal string';
                              }
                              return null;
                            },
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
                                decoration: const InputDecoration(
                                  labelText: 'Passphrase',
                                  hintText: 'eg. MySecretPassphrase',
                                ),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextFormField(
                                        controller: shares,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Shares',
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              int.tryParse(value) == null) {
                                            return 'Fill with an integer';
                                          }
                                          return null;
                                        },
                                      ))),
                              const Spacer(),
                              Flexible(
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextFormField(
                                        controller: threshold,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Threshold',
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              int.tryParse(value) == null) {
                                            return 'Fill with an integer';
                                          }
                                          return null;
                                        },
                                      ))),
                            ],
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal, backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            List<List<int>> scheme = [
                              for (var i = 0; i < int.parse(shares.text); i++)
                                [1, 1]
                            ];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SharesScreen(
                                        slip: Slip39.from(scheme,
                                            masterSecret: Uint8List.fromList(
                                                hex.decode(secret.text)),
                                            passphrase: passphrase.text,
                                            threshold:
                                                int.parse(threshold.text)),
                                      )),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      )),
                ],
              ),
            ))));
  }
}
