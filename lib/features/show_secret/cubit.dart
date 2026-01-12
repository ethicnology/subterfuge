import 'package:bip32_keys/bip32_keys.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/features/show_secret/state.dart';

class ShowSecretCubit extends Cubit<ShowSecretState> {
  ShowSecretCubit({required Uint8List secret})
    : super(ShowSecretState(secret: secret)) {
    _deriveExtendedPublicKey();
  }

  void setScriptType(ScriptType scriptType) {
    emit(state.copyWith(scriptType: scriptType));
    _deriveExtendedPublicKey();
  }

  void setAccount(int account) {
    final safeAccount = account < 0 ? 0 : account;
    emit(state.copyWith(account: safeAccount));
    _deriveExtendedPublicKey();
  }

  void _deriveExtendedPublicKey() {
    try {
      final Uint8List seed;
      if (state.isEntropy) {
        // Entropy (128-256 bits): convert to mnemonic, then derive seed
        final mnemonic = Mnemonic(state.secret, Language.english);
        seed = Uint8List.fromList(mnemonic.seed);
      } else {
        // Seed (512 bits): use directly
        seed = state.secret;
      }

      final masterNode = Bip32MasterNode.fromSeed(seed);

      final Bip32Accounts wallet;
      switch (state.scriptType) {
        case ScriptType.legacy:
          wallet = masterNode.toBip44Legacy(account: state.account);
          break;
        case ScriptType.nestedSegwit:
          wallet = masterNode.toBip49NestedSegwit(account: state.account);
          break;
        case ScriptType.segwit:
          wallet = masterNode.toBip84SegwitWallet(account: state.account);
          break;
      }

      emit(
        state.copyWith(
          extendedPublicKey: wallet.extendedPublicKey,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(extendedPublicKey: null, error: e.toString()));
    }
  }
}
