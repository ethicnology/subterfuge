import 'package:flutter/material.dart';
import 'package:subterfuge/screen/secret.dart';
import 'package:slip39/slip39.dart';

class RecoverSecretScreen extends StatefulWidget {
  const RecoverSecretScreen({super.key});

  @override
  State<RecoverSecretScreen> createState() => _RecoverSecretScreenState();
}

class _RecoverSecretScreenState extends State<RecoverSecretScreen> {
  final _formKey = GlobalKey<FormState>();
  int nbShares = 0;
  bool hasPassphrase = false;
  String passphrase = "";
  Map shares = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recover a secret')),
        body: Form(
            key: _formKey,
            child: Center(
                child: SizedBox(
                    width: 500,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(
                          width: 130,
                          child: Card(
                              color: Colors.teal,
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Shares',
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        int.tryParse(value) == null) {
                                      return 'Fill with an integer';
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    setState(() {
                                      if (value == "") {
                                        nbShares = 0;
                                      } else {
                                        nbShares = int.parse(value);
                                      }
                                    });
                                  },
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
                                    passphrase = "";
                                  });
                                }),
                            if (hasPassphrase)
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  onChanged: (v) =>
                                      setState(() => passphrase = v),
                                  decoration: const InputDecoration(
                                      labelText: 'Passphrase'),
                                ),
                              ),
                          ])),
                      if (nbShares > 0)
                        for (int i = 0; i < nbShares; i++)
                          Card(
                              color: Colors.teal,
                              child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'shares ${i + 1}',
                                    ),
                                    onChanged: (String value) {
                                      shares[i] = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Fill with a sentence';
                                      }
                                      return null;
                                    },
                                  ))),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var sharesList = List<String>.from(shares.values);
                            List<int> secret = Slip39.recoverSecret(
                              sharesList,
                              passphrase: passphrase,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SecretScreen(secret: secret),
                                ));
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ]))))));
  }
}
