import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/merge_shares/cubit.dart';
import 'package:subterfuge/features/merge_shares/state.dart';
import 'package:subterfuge/features/show_secret/page.dart';

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
                backgroundColor: Colors.red,
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
                    child: Column(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Card(
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
                                onChanged: (String value) {
                                  final count = int.tryParse(value) ?? 0;
                                  cubit.setSharesCount(count);
                                },
                              ),
                            ),
                          ),
                        ),
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
                        if (state.sharesCount > 0)
                          for (int i = 0; i < state.sharesCount; i++)
                            Card(
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
                        FilledButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final shares = <String>[];
                              for (int i = 0; i < state.sharesCount; i++) {
                                final input = shareControllers[i]?.text ?? '';
                                shares.add(input.trim());
                              }

                              cubit.mergeShares(
                                sharesCount: state.sharesCount,
                                shares: shares,
                                passphrase: passphraseController.text.trim(),
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle_rounded),
                          label: const Text('Submit'),
                        ),
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
