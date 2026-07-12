import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/foundation.dart';

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

/// Sentinel used to distinguish "argument not passed" from "argument
/// explicitly set to null" in [ShowSecretState.copyWith].
const Object _unset = Object();

class ShowSecretState {
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

  ShowSecretState copyWith({
    ScriptType? scriptType,
    int? account,
    Object? extendedPublicKey = _unset,
    Object? error = _unset,
  }) {
    return ShowSecretState(
      secret: secret,
      scriptType: scriptType ?? this.scriptType,
      account: account ?? this.account,
      extendedPublicKey: identical(extendedPublicKey, _unset)
          ? this.extendedPublicKey
          : extendedPublicKey as String?,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }

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

  // Secret material is intentionally NOT included here: never
  // log/print/persist this state. Keep this override minimal and redacted
  // so any accidental future `print(state)` / crash-report attachment
  // cannot leak the secret, mnemonic, or derived key.
  @override
  String toString() =>
      'ShowSecretState(secretType: $secretType, scriptType: $scriptType, '
      'account: $account, hasExtendedPublicKey: ${extendedPublicKey != null}, '
      'error: ${error == null ? 'none' : 'present'})';
}
