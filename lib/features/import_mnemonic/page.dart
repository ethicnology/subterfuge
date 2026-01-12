import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:subterfuge/features/import_mnemonic/mnemonic_widget.dart';
import 'package:subterfuge/features/share_secret/page.dart';

class ImportMnemonicPage extends StatelessWidget {
  const ImportMnemonicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import Mnemonic')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MnemonicWidget(
          // Passphrase disabled: would require backing up 512-bit seed instead of entropy,
          // resulting in 59-word SLIP-39 shares unsupported by most hardware wallets.
          allowPassphrase: false,
          onSubmit: (mnemonic) {
            // !!! IMPORTANT !!!
            // - Entropy (128/256 bits) → 20/33-word SLIP-39 shares (standard, hardware wallet compatible)
            // - Seed (512 bits) → 59-word SLIP-39 shares (unsupported by most wallets)
            // When passphrase is empty, backup entropy to recover BIP-39 mnemonic later.
            // When passphrase is used, we must backup the seed (losing the original mnemonic).
            List<int> secret;
            if (mnemonic.passphrase.isEmpty) {
              secret = mnemonic.entropy;
            } else {
              secret = mnemonic.seed;
            }

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ShareSecretPage(secret: hex.encode(secret)),
              ),
            );
          },
        ),
      ),
    );
  }
}
