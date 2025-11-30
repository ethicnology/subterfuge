import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/import_mnemonic/page.dart';
import 'package:subterfuge/features/show_shares/page.dart';
import 'cubit.dart';
import 'state.dart';

class ShareSecretPage extends StatefulWidget {
  final String? secret;
  const ShareSecretPage({super.key, this.secret});

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
  void initState() {
    super.initState();
    if (widget.secret != null) {
      secret.text = widget.secret!;
    }
  }

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
            previous.error != current.error,
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
                      if (widget.secret == null) ...[
                        MaterialBanner(
                          padding: const EdgeInsets.all(20),
                          content: const Text(
                            'Your secret is a seed?\nYou don\'t know your seed?\nExtract it from your mnemonic.',
                            style: TextStyle(color: Colors.black),
                          ),
                          leading: const Icon(
                            Icons.help,
                            color: Colors.black,
                            size: 32,
                          ),
                          backgroundColor: Colors.tealAccent,
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ImportMnemonicPage(),
                                  ),
                                );
                              },
                              child: const Text('Mnemonic'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                      Card(
                        child: Padding(
                          padding: const .all(7),
                          child: TextFormField(
                            controller: secret,
                            readOnly: widget.secret != null,
                            autovalidateMode: .onUserInteraction,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'eg. 0123456789abcdef0123456789ABCDEF',
                              labelText: 'Secret',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Hexadecimal seed';
                              }
                              if (value.length < 32) {
                                return 'At least 32 characters (16 bytes)';
                              }
                              if (!((value.length % 2) == 0)) {
                                return 'Not an even number of characters';
                              }
                              try {
                                hex.decode(value);
                              } catch (e) {
                                return 'Invalid hexadecimal seed';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const .all(7),
                              child: TextFormField(
                                enableSuggestions: false,
                                autocorrect: false,
                                controller: passphrase,
                                decoration: const InputDecoration(
                                  labelText: 'Passphrase (optional)',
                                  hintText:
                                      'eg. ThisIsNotYourMnemonicPassphrase',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const .all(7),
                          child: Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextFormField(
                                    controller: participants,
                                    keyboardType: .number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Participants',
                                    ),
                                    autovalidateMode: .onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          int.tryParse(value) == null) {
                                        return 'Between 1 and 16';
                                      }
                                      if (int.parse(value) < 1 ||
                                          int.parse(value) > 16) {
                                        return 'Between 1 and 16';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Flexible(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextFormField(
                                    controller: threshold,
                                    keyboardType: .number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Threshold',
                                    ),
                                    autovalidateMode: .onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          int.tryParse(value) == null) {
                                        return 'Between 1 and 16';
                                      }
                                      if (int.parse(value) < 1 ||
                                          int.parse(value) > 16) {
                                        return 'Between 1 and 16';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const .only(top: 3),
                        child: FilledButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.shareSecret(
                                      participants: int.parse(
                                        participants.text,
                                      ),
                                      threshold: int.parse(threshold.text),
                                      masterSecret: Uint8List.fromList(
                                        hex.decode(secret.text),
                                      ),
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
