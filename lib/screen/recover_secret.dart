import 'package:flutter/material.dart';
import 'package:subterfuge/screen/secret.dart';
import 'package:slip39/slip39.dart';

class RecoverSecretScreen extends StatefulWidget {
  const RecoverSecretScreen({Key? key}) : super(key: key);

  @override
  State<RecoverSecretScreen> createState() => _RecoverSecretScreenState();
}

class _RecoverSecretScreenState extends State<RecoverSecretScreen> {
  int nbShares = 0;
  bool hasPassphrase = false;
  String passphrase = "";
  Map shares = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recover Shared Secret')),
        body: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Card(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Number of shares',
                      ),
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
                  )),
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
                            onChanged: (String value) {
                              setState(() {
                                passphrase = value;
                              });
                            },
                            decoration:
                                const InputDecoration(labelText: 'Passphrase'),
                          )),
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
                          ))),
              ElevatedButton(
                onPressed: () {
                  var sharesList = List<String>.from(shares.values);
                  List<int> secret = Slip39.recoverSecret(
                    sharesList,
                    passphrase: passphrase,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecretScreen(
                          secret: secret,
                        ),
                      ));
                },
                child: const Text('Submit'),
              ),
            ])));
  }
}
