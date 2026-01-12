import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';

part 'state.mapper.dart';

enum ScriptType {
  legacy(title: 'Legacy (BIP44)'),
  nestedSegwit(title: 'Nested Segwit (BIP49)'),
  segwit(title: 'Segwit (BIP84)');

  final String title;
  const ScriptType({required this.title});
}

/// Type of secret based on bit length:
/// - Entropy (128-256 bits): Original BIP-39 mnemonic entropy
/// - Seed (512 bits): BIP-39 generated seed from mnemonic + passphrase
enum SecretType {
  entropy(title: 'Entropy (128-256 bits)'),
  seed(title: 'Seed (512 bits)');

  final String title;
  const SecretType({required this.title});

  /// Auto-detect secret type based on byte length
  static SecretType fromBytes(Uint8List secret) {
    final bits = secret.length * 8;
    if (bits == 512) return SecretType.seed;

    // 128, 160, 192, 224, or 256 bits = entropy
    return SecretType.entropy;
  }
}

@MappableClass()
class ShowSecretState with ShowSecretStateMappable {
  final Uint8List secret;
  final ScriptType scriptType;
  final int account;
  final String? extendedPublicKey;
  final String? error;

  const ShowSecretState({
    required this.secret,
    this.scriptType = ScriptType.segwit,
    this.account = 0,
    this.extendedPublicKey,
    this.error,
  });

  /// Auto-detected secret type based on length
  SecretType get secretType => SecretType.fromBytes(secret);

  /// Whether the secret is entropy (can be converted to mnemonic)
  bool get isEntropy => secretType == SecretType.entropy;

  /// Whether the secret is a seed (512 bits, used directly for derivation)
  bool get isSeed => secretType == SecretType.seed;

  /// Secret as hex string (for seeds)
  String get secretHex {
    final buffer = StringBuffer();
    for (final byte in secret) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }

  /// Mnemonic sentence (only valid if isEntropy)
  String? get mnemonicSentence {
    if (!isEntropy) return null;
    try {
      final mnemonic = Mnemonic(secret, Language.english);
      return mnemonic.sentence;
    } catch (_) {
      return null;
    }
  }

  /// Display value: mnemonic sentence for entropy, hex for seed
  String get displaySecret {
    if (isEntropy) {
      return mnemonicSentence ?? secretHex;
    }
    return secretHex;
  }
}
