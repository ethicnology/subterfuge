import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/shared/errors.dart';
import 'dart:typed_data';
import 'state.dart';
import '../../shared/slip39_facade.dart';

class ShareSecretCubit extends Cubit<ShareSecretState> {
  ShareSecretCubit() : super(ShareSecretState());

  void shareSecret({
    required int participants,
    required int threshold,
    required Uint8List masterSecret,
    required String passphrase,
  }) {
    emit(state.copyWith(isLoading: true));

    try {
      final secretShares = Slip39Facade.share(
        shares: participants,
        threshold: threshold,
        masterSecret: masterSecret,
        passphrase: passphrase,
      );

      emit(state.copyWith(shares: secretShares));
    } catch (e) {
      if (e is AppError) {
        emit(state.copyWith(error: AppError(e.message)));
      } else {
        emit(state.copyWith(error: AppError(e.toString())));
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
