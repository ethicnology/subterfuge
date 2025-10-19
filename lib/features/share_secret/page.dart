import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/show_shares/page.dart';
import 'cubit.dart';
import 'state.dart';

class ShareSecretPage extends StatefulWidget {
  const ShareSecretPage({super.key});

  @override
  State<ShareSecretPage> createState() => _ShareSecretState();
}

class _ShareSecretState extends State<ShareSecretPage> {
  final _formKey = GlobalKey<FormState>();
  final secret = TextEditingController();
  final passphrase = TextEditingController();
  final participants = TextEditingController();
  final threshold = TextEditingController();
  final random = Random.secure();

  @override
  void dispose() {
    secret.dispose();
    passphrase.dispose();
    participants.dispose();
    threshold.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareSecretCubit(),
      child: BlocConsumer<ShareSecretCubit, ShareSecretState>(
        listenWhen: (previous, current) =>
            previous.shares.isEmpty && current.shares.isNotEmpty ||
            previous.error != null && current.error == null,
        listener: (context, state) {
          final cubit = context.read<ShareSecretCubit>();

          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!.message),
                backgroundColor: Colors.red,
              ),
            );
            cubit.clearError();
          }
          if (state.shares.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowSharesPage(shares: state.shares),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ShareSecretCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text('Share a secret')),
            body: Form(
              key: _formKey,
              child: Center(
                child: SizedBox(
                  width: 500,
                  child: Column(
                    children: [
                      Card(
                          color: Colors.teal,
                          child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: TextFormField(
                                controller: secret,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText:
                                      'eg. 0123456789abcdef0123456789ABCDEF',
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
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: TextFormField(
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: passphrase,
                              decoration: const InputDecoration(
                                labelText: 'Passphrase (optional)',
                                hintText: 'eg. MySecretPassphrase',
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Card(
                          color: Colors.teal,
                          child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextFormField(
                                        controller: participants,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Participants',
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              int.tryParse(value) == null) {
                                            return 'Fill with an integer';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
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
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.teal,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.shareSecret(
                                      participants:
                                          int.parse(participants.text),
                                      threshold: int.parse(threshold.text),
                                      masterSecret: Uint8List.fromList(
                                          hex.decode(secret.text)),
                                      passphrase: passphrase.text,
                                    );
                                  }
                                },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
