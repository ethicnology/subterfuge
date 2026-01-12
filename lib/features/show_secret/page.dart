import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/show_secret/cubit.dart';
import 'package:subterfuge/features/show_secret/state.dart';

class ShowSecretPage extends StatelessWidget {
  final Uint8List secret;
  const ShowSecretPage({super.key, required this.secret});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowSecretCubit(secret: secret),
      child: const _ShowSecretView(),
    );
  }
}

class _ShowSecretView extends StatefulWidget {
  const _ShowSecretView();

  @override
  State<_ShowSecretView> createState() => _ShowSecretViewState();
}

class _ShowSecretViewState extends State<_ShowSecretView> {
  final TextEditingController _accountController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowSecretCubit, ShowSecretState>(
      builder: (context, state) {
        final cubit = context.read<ShowSecretCubit>();

        return Scaffold(
          appBar: AppBar(title: const Text('Secret')),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_open_rounded,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  _SecretCard(
                    title: state.isEntropy ? 'Mnemonic' : 'Seed',
                    icon: state.isEntropy
                        ? Icons.article_rounded
                        : Icons.key_rounded,
                    content: state.displaySecret,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.secretType.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<ScriptType>(
                    initialValue: state.scriptType,
                    decoration: const InputDecoration(
                      labelText: 'Script Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ScriptType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        cubit.setScriptType(value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _accountController,
                    decoration: const InputDecoration(
                      labelText: 'Account',
                      border: OutlineInputBorder(),
                      helperText: 'Account index (default: 0)',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      final account = int.tryParse(value) ?? 0;
                      cubit.setAccount(account);
                    },
                  ),
                  if (state.extendedPublicKey != null) ...[
                    const SizedBox(height: 16),
                    _SecretCard(
                      title: 'Extended Public Key',
                      icon: Icons.public_rounded,
                      content: state.extendedPublicKey!,
                    ),
                  ],
                  if (state.error != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      state.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.check_circle_rounded),
                    label: const Text('Done'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SecretCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const _SecretCard({
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                content,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: content));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$title copied to clipboard'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.copy_rounded),
              label: const Text('Copy'),
            ),
          ],
        ),
      ),
    );
  }
}
