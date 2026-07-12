import 'dart:typed_data';

import 'package:subterfuge/shared/errors.dart';

/// Sentinel used to distinguish "argument not passed" from "argument
/// explicitly set to null" in [MergeSharesState.copyWith].
const Object _unset = Object();

class MergeSharesState {
  final int sharesCount;
  final Map<int, String> shares;
  final AppError? error;
  final Uint8List? secret;
  final bool isLoading;

  const MergeSharesState({
    // Defaults to 2 (rather than 0) so the form starts with two ready-to-
    // paste share fields visible instead of an empty count with nothing
    // to fill in yet — most recoveries need at least 2 shares.
    this.sharesCount = 2,
    this.shares = const {},
    this.error,
    this.secret,
    this.isLoading = false,
  });

  MergeSharesState copyWith({
    int? sharesCount,
    Map<int, String>? shares,
    Object? error = _unset,
    Object? secret = _unset,
    bool? isLoading,
  }) {
    return MergeSharesState(
      sharesCount: sharesCount ?? this.sharesCount,
      shares: shares ?? this.shares,
      error: identical(error, _unset) ? this.error : error as AppError?,
      secret: identical(secret, _unset) ? this.secret : secret as Uint8List?,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // Secret material is intentionally NOT included here: never
  // log/print/persist this state. Keep this override minimal and redacted
  // so any accidental future `print(state)` / crash-report attachment
  // cannot leak the recovered secret.
  @override
  String toString() =>
      'MergeSharesState(sharesCount: $sharesCount, hasSecret: ${secret != null}, isLoading: $isLoading, error: ${error == null ? 'none' : 'present'})';
}
