import 'package:subterfuge/shared/errors.dart';

/// Sentinel used to distinguish "argument not passed" from "argument
/// explicitly set to null" in [ShareSecretState.copyWith].
const Object _unset = Object();

class ShareSecretState {
  final bool isLoading;
  final List<String> shares;
  final AppError? error;

  const ShareSecretState({
    this.isLoading = false,
    this.shares = const [],
    this.error,
  });

  ShareSecretState copyWith({
    bool? isLoading,
    List<String>? shares,
    Object? error = _unset,
  }) {
    return ShareSecretState(
      isLoading: isLoading ?? this.isLoading,
      shares: shares ?? this.shares,
      error: identical(error, _unset) ? this.error : error as AppError?,
    );
  }

  // Secret material (shares) is intentionally NOT included here: never
  // log/print/persist this state. Keep this override minimal and redacted
  // so any accidental future `print(state)` / crash-report attachment
  // cannot leak share content.
  @override
  String toString() =>
      'ShareSecretState(isLoading: $isLoading, shares: <redacted x${shares.length}>, error: ${error == null ? 'none' : 'present'})';
}
