import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/import_mnemonic/page.dart';
import 'package:subterfuge/features/show_shares/page.dart';
import 'package:subterfuge/shared/info_banner.dart';
import 'package:subterfuge/shared/number_stepper_field.dart';
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

  // Pre-filled with sensible, commonly-used defaults (3 participants, a
  // 2-of-3 threshold) rather than starting empty: most first-time users
  // have never configured an m-of-n secret-sharing scheme before, and a
  // working example to tweak is far more approachable than a blank field.
  int _participants = 3;
  int _threshold = 2;

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
                backgroundColor: Theme.of(context).colorScheme.error,
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
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 500,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.secret == null) ...[
                          InfoBanner(
                            icon: Icons.help_outline_rounded,
                            content: const Text(
                              'Your secret is a mnemonic? '
                              'Extract the entropy first.',
                            ),
                            action: FilledButton(
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
                          ),
                          const SizedBox(height: 16),
                        ],
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextFormField(
                              controller: secret,
                              readOnly: widget.secret != null,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.visiblePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText:
                                    'eg. 0123456789abcdef0123456789ABCDEF',
                                labelText: 'Secret',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Hexadecimal input';
                                }
                                if (value.length < 32) {
                                  return 'At least 32 characters (16 bytes)';
                                }
                                if (value.length > 128) {
                                  return 'At most 128 characters (64 bytes)';
                                }
                                // SLIP-39 requires an even number of BYTES,
                                // i.e. a hex string length that is a
                                // multiple of 4 (2 hex chars per byte).
                                if (value.length % 4 != 0) {
                                  return 'Must be a multiple of 4 characters (whole bytes, even count)';
                                }
                                try {
                                  hex.decode(value);
                                } catch (e) {
                                  return 'Invalid hexadecimal input';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextFormField(
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: passphrase,
                              decoration: const InputDecoration(
                                labelText: 'Passphrase (optional)',
                                hintText: 'eg. ThisIsNotYourMnemonicPassphrase',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: NumberStepperField(
                                        label: 'Participants',
                                        min: 1,
                                        max: 16,
                                        initialValue: _participants,
                                        onChanged: (value) {
                                          setState(() => _participants = value);
                                          // Re-validate the threshold field
                                          // whenever participants changes,
                                          // so "threshold <= participants"
                                          // is always enforced live.
                                          _formKey.currentState?.validate();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: NumberStepperField(
                                        label: 'Threshold',
                                        min: 1,
                                        max: 16,
                                        initialValue: _threshold,
                                        onChanged: (value) =>
                                            setState(() => _threshold = value),
                                        validator: (value) {
                                          if (value != null &&
                                              value > _participants) {
                                            return 'Cannot exceed participants ($_participants)';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Live summary so the m-of-n scheme being
                                // configured is unambiguous before
                                // submitting.
                                Text(
                                  '$_participants shares will be created; '
                                  '$_threshold of them will be needed to '
                                  'recover the secret.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.shareSecret(
                                      participants: _participants,
                                      threshold: _threshold,
                                      masterSecret: Uint8List.fromList(
                                        hex.decode(secret.text),
                                      ),
                                      passphrase: passphrase.text,
                                    );
                                  }
                                },
                          icon: state.isLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  ),
                                )
                              : const Icon(Icons.check_circle_rounded),
                          label: Text(
                            state.isLoading ? 'Generating…' : 'Submit',
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
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
