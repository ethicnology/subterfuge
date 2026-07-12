import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/shared/errors.dart';
import 'dart:typed_data';
import 'state.dart';
import '../../shared/slip39_facade.dart';

class ShareSecretCubit extends Cubit<ShareSecretState> {
  ShareSecretCubit() : super(ShareSecretState());

  Future<void> shareSecret({
    required int participants,
    required int threshold,
    required Uint8List masterSecret,
    required String passphrase,
  }) async {
    emit(state.copyWith(shares: [], error: null, isLoading: true));

    try {
      // Runs off the UI thread: PBKDF2 (20000 iterations) would otherwise
      // visibly hitch the frame for larger participant/threshold counts.
      final secretShares = await Slip39Facade.shareAsync(
        shares: participants,
        threshold: threshold,
        masterSecret: masterSecret,
        passphrase: passphrase,
      );

      emit(state.copyWith(shares: secretShares));
    } catch (e) {
      emit(state.copyWith(error: toSafeAppError(e)));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
