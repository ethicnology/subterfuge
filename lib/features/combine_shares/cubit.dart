import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subterfuge/shared/slip39_facade.dart';
import 'state.dart';

class CombineSharesCubit extends Cubit<CombineSharesState> {
  CombineSharesCubit() : super(CombineSharesState());

  void setSharesCount(int sharesCount) {
    emit(state.copyWith(sharesCount: sharesCount));
  }

  void combineShares({
    required int sharesCount,
    required Map<int, String> shares,
    required String passphrase,
  }) {
    var sharesList = List<String>.from(shares.values);

    final secret = Slip39Facade.combine(
      shares: sharesList,
      passphrase: passphrase,
    );

    emit(state.copyWith(secret: secret, error: null));
  }

  void clearError() => emit(state.copyWith(error: null));
}
