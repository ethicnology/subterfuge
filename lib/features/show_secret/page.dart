import 'package:bip32_keys/bip32_keys.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ScriptType {
  legacy(title: 'Legacy (BIP44)'),
  nestedSegwit(title: 'Nested Segwit (BIP49)'),
  segwit(title: 'Segwit (BIP84)');

  final String title;
  const ScriptType({required this.title});
}

class ShowSecretPage extends StatefulWidget {
  final Uint8List secret;
  const ShowSecretPage({super.key, required this.secret});

  @override
  State<ShowSecretPage> createState() => _ShowSecretPageState();
}

class _ShowSecretPageState extends State<ShowSecretPage> {
  bool isSeed = false;
  ScriptType _selectedScriptType = ScriptType.segwit;
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
    String? extendedPublicKey;
    if (isSeed) {
      try {
        final masterNode = Bip32MasterNode.fromSeed(widget.secret);
        final int account = int.tryParse(_accountController.text) ?? 0;
        final safeAccount = account < 0 ? 0 : account;

        final Bip32Accounts wallet;
        switch (_selectedScriptType) {
          case ScriptType.legacy:
            wallet = masterNode.toBip44Legacy(account: safeAccount);
            break;
          case ScriptType.nestedSegwit:
            wallet = masterNode.toBip49NestedSegwit(account: safeAccount);
            break;
          case ScriptType.segwit:
            wallet = masterNode.toBip84SegwitWallet(account: safeAccount);
            break;
        }
        extendedPublicKey = wallet.extendedPublicKey;
      } catch (_) {
        // Handle derivation errors if any
      }
    }

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
                title: 'Your Secret',
                icon: Icons.key_rounded,
                content: hex.encode(widget.secret),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('The secret is a Seed'),
                value: isSeed,
                onChanged: (value) => setState(() => isSeed = value),
              ),
              if (isSeed) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<ScriptType>(
                  initialValue: _selectedScriptType,
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
                      setState(() => _selectedScriptType = value);
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
                  onChanged: (_) => setState(() {}),
                ),
                if (extendedPublicKey != null) ...[
                  const SizedBox(height: 16),
                  _SecretCard(
                    title: 'Extended Public Key',
                    icon: Icons.public_rounded,
                    content: extendedPublicKey,
                  ),
                ],
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
