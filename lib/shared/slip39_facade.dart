import 'dart:typed_data';

import 'package:slip39/slip39.dart';

class Slip39Facade {
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
