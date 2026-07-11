import 'dart:typed_data';

import 'package:slip39/slip39.dart';

class Slip39Facade {
  /// Iteration exponent for the PBKDF2-SHA256 encryption round of the master
  /// secret (SLIP-39 §"Encrypting the Master Secret"). `e = 1` means
  /// 10000 << 1 = 20000 iterations, matching the Trezor/reference-implementation
  /// default and doubling the spec-minimum (`e = 0` → 10000 iterations). This
  /// value is encoded in every generated share, so recovery always uses
  /// whatever exponent the shares were created with.
  static const int _defaultIterationExponent = 1;

  static List<String> share({
    required int shares,
    required int threshold,
    required Uint8List masterSecret,
    required String passphrase,
  }) {
    List<List<int>> scheme = List.generate(shares, (_) => [1, 1]);
    final slip = Slip39.from(
      scheme,
      masterSecret: masterSecret,
      passphrase: passphrase,
      threshold: threshold,
      iterationExponent: _defaultIterationExponent,
    );

    final secretShares = <String>[];
    for (var i = 0; i < slip.groupCount; i++) {
      secretShares.addAll(slip.fromPath('r/$i').mnemonics);
    }
    return secretShares;
  }

  static Uint8List combine({
    required List<String> shares,
    required String passphrase,
  }) {
    final secret = Slip39.recoverSecret(shares, passphrase: passphrase);
    return Uint8List.fromList(secret);
  }
}
