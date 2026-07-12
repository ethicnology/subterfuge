import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/shared/errors.dart';
import 'package:subterfuge/shared/slip39_facade.dart';
import 'state.dart';

class MergeSharesCubit extends Cubit<MergeSharesState> {
  MergeSharesCubit() : super(MergeSharesState());

  void setSharesCount(int sharesCount) {
    emit(state.copyWith(sharesCount: sharesCount));
  }

  Future<void> mergeShares({
    required int sharesCount,
    required List<String> shares,
    required String passphrase,
  }) async {
    try {
      emit(state.copyWith(error: null, secret: null, isLoading: true));

      // Runs off the UI thread — see Slip39Facade.combineAsync.
      final secret = await Slip39Facade.combineAsync(
        shares: shares,
        passphrase: passphrase,
      );

      emit(state.copyWith(secret: secret));
    } catch (e) {
      emit(state.copyWith(error: toSafeAppError(e)));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
