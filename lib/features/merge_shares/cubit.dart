import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/shared/errors.dart';
import 'package:subterfuge/shared/slip39_facade.dart';
import 'state.dart';

class MergeSharesCubit extends Cubit<MergeSharesState> {
  MergeSharesCubit() : super(MergeSharesState());

  void setSharesCount(int sharesCount) {
    emit(state.copyWith(sharesCount: sharesCount));
  }

  void mergeShares({
    required int sharesCount,
    required List<String> shares,
    required String passphrase,
  }) {
    try {
      emit(state.copyWith(error: null, secret: null));

      final secret = Slip39Facade.combine(
        shares: shares,
        passphrase: passphrase,
      );

      emit(state.copyWith(secret: secret));
    } catch (e) {
      if (e is AppError) {
        emit(state.copyWith(error: AppError(e.message)));
      } else {
        emit(state.copyWith(error: AppError(e.toString())));
      }
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
