class AppError implements Exception {
  final String message;

  AppError(this.message);

  @override
  String toString() => message;
}

/// Converts an arbitrary caught exception into a safe, user-facing [AppError].
///
/// Some dependencies (slip39, bip39_mnemonic) embed sensitive material
/// (mnemonic words, group/threshold details derived from the secret) inside
/// their raw exception messages. To avoid ever surfacing that content
/// verbatim (in the UI today, and to guard against any future logging or
/// crash-reporting integration), only [AppError]s we already control are
/// passed through as-is. Every other exception type is mapped to a generic,
/// safe message.
AppError toSafeAppError(
  Object error, {
  String fallback = 'Operation failed. Please check your inputs and try again.',
}) {
  if (error is AppError) return error;
  return AppError(fallback);
}
