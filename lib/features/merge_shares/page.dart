import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/merge_shares/cubit.dart';
import 'package:subterfuge/features/merge_shares/state.dart';
import 'package:subterfuge/features/show_secret/page.dart';
import 'package:subterfuge/shared/number_stepper_field.dart';

class MergeSharesPage extends StatefulWidget {
  const MergeSharesPage({super.key});

  @override
  State<MergeSharesPage> createState() => _RecoverSecretScreenState();
}

class _RecoverSecretScreenState extends State<MergeSharesPage> {
  final _formKey = GlobalKey<FormState>();
  final passphraseController = TextEditingController();
  final Map<int, TextEditingController> shareControllers = {};

  @override
  void dispose() {
    passphraseController.dispose();
    for (final controller in shareControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MergeSharesCubit(),
      child: BlocConsumer<MergeSharesCubit, MergeSharesState>(
        listenWhen: (previous, current) =>
            previous.secret == null && current.secret != null ||
            previous.error != current.error,
        listener: (context, state) {
          final cubit = context.read<MergeSharesCubit>();

          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            cubit.clearError();
          }
          if (state.secret != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowSecretPage(secret: state.secret!),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<MergeSharesCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text('Merge shares')),
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
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: NumberStepperField(
                                label: 'Shares to combine',
                                min: 1,
                                max: 16,
                                initialValue: state.sharesCount,
                                onChanged: cubit.setSharesCount,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: TextFormField(
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  controller: passphraseController,
                                  decoration: const InputDecoration(
                                    labelText: 'Passphrase (optional)',
                                    hintText: 'eg. MySecretPassphrase',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (state.sharesCount > 0)
                          for (int i = 0; i < state.sharesCount; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: TextFormField(
                                    controller: shareControllers.putIfAbsent(
                                      i,
                                      () => TextEditingController(),
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'shares ${i + 1}',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Fill with a sentence';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                        FilledButton.icon(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final shares = <String>[];
                                    for (
                                      int i = 0;
                                      i < state.sharesCount;
                                      i++
                                    ) {
                                      final input =
                                          shareControllers[i]?.text ?? '';
                                      // Normalize pasted content: collapse
                                      // any run of whitespace (newlines,
                                      // tabs, double spaces from
                                      // copy/paste) into single spaces and
                                      // lowercase, since slip39 splits
                                      // words on a single ' ' and the
                                      // wordlist is lowercase.
                                      shares.add(
                                        input.trim().toLowerCase().replaceAll(
                                          RegExp(r'\s+'),
                                          ' ',
                                        ),
                                      );
                                    }

                                    cubit.mergeShares(
                                      sharesCount: state.sharesCount,
                                      shares: shares,
                                      passphrase: passphraseController.text
                                          .trim(),
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
                            state.isLoading ? 'Recovering…' : 'Submit',
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
