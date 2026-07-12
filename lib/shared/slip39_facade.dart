import 'package:flutter/foundation.dart';
import 'package:slip39/slip39.dart';

/// Arguments for [_computeShare], bundled into one record so it can be
/// passed as the single message argument [compute] requires.
typedef _ShareArgs = (
  int shares,
  int threshold,
  Uint8List masterSecret,
  String passphrase,
);

/// Arguments for [_computeCombine].
typedef _CombineArgs = (List<String> shares, String passphrase);

// Top-level functions (required by `compute()`, which spawns a new isolate
// and can only run a static/top-level callback there — it can't capture
// `this` or any surrounding closure state).
List<String> _computeShare(_ShareArgs args) => Slip39Facade.share(
  shares: args.$1,
  threshold: args.$2,
  masterSecret: args.$3,
  passphrase: args.$4,
);

Uint8List _computeCombine(_CombineArgs args) =>
    Slip39Facade.combine(shares: args.$1, passphrase: args.$2);

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

  /// Same as [share], but runs the PBKDF2-heavy encryption step in a
  /// background isolate via [compute] so the UI thread (and its "Submit"
  /// button spinner) stays responsive instead of hitching for the duration
  /// of the computation.
  ///
  /// `compute` spawns a real OS thread/isolate on Android/iOS/desktop; on
  /// Flutter web (which has no isolates) it transparently falls back to
  /// running synchronously on the same thread — still correct, just without
  /// the responsiveness benefit there.
  static Future<List<String>> shareAsync({
    required int shares,
    required int threshold,
    required Uint8List masterSecret,
    required String passphrase,
  }) => compute(_computeShare, (shares, threshold, masterSecret, passphrase));

  /// Same as [combine], but off the UI thread — see [shareAsync].
  static Future<Uint8List> combineAsync({
    required List<String> shares,
    required String passphrase,
  }) => compute(_computeCombine, (shares, passphrase));
}
