import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slip39/slip39.dart';

void main() {
  testWidgets('Test 2/5 without passphrase', (WidgetTester tester) async {
    var scheme = [
      for (var i = 0; i < 5; i++) [1, 1]
    ];
    const inputSecret =
        'fd43b5abd947c9a8c55416008840537ab40bde5ab6d315fbcad5938302f78ec6';
    const threshold = 2;

    final created = Slip39.from(
      scheme,
      masterSecret: Uint8List.fromList(hex.decode(inputSecret)),
      passphrase: '',
      threshold: threshold,
    );

    List<String> shares = [];
    for (var i = 0; i < created.groupCount; i++) {
      shares.addAll(created.fromPath('r/$i').mnemonics);
    }

    List<int> recovered = Slip39.recoverSecret(
      [shares[0], shares[1]],
      passphrase: '',
    );

    final outputSecret = hex.encode(recovered);
    expect(inputSecret, outputSecret);
  });

  testWidgets('Test 3/5 without passphrase', (WidgetTester tester) async {
    var scheme = [
      for (var i = 0; i < 5; i++) [1, 1]
    ];
    const inputSecret =
        '99e0cda36055002ea4c60fcdbbe1d76beff3e7bcb421ab0db0fa1e034385f5c3';
    const passphrase = 'azerty';
    const threshold = 3;

    final created = Slip39.from(
      scheme,
      masterSecret: Uint8List.fromList(hex.decode(inputSecret)),
      passphrase: passphrase,
      threshold: threshold,
    );

    List<String> shares = [];
    for (var i = 0; i < created.groupCount; i++) {
      shares.addAll(created.fromPath('r/$i').mnemonics);
    }

    final recovered = Slip39.recoverSecret(
      [shares[0], shares[1], shares[4]],
      passphrase: passphrase,
    );

    final outputSecret = hex.encode(recovered);
    expect(inputSecret, outputSecret);
  });
}
