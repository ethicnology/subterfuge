import 'package:flutter/material.dart';
import 'package:subterfuge/features/import_mnemonic/mnemonic_widget.dart';

class ImportMnemonicPage extends StatelessWidget {
  const ImportMnemonicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Mnemonic'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MnemonicWidget(
          onSubmit: (mnemonic) {},
        ),
      ),
    );
  }
}
