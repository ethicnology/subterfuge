import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:subterfuge/shared/errors.dart';

part 'state.mapper.dart';

@MappableClass()
class MergeSharesState with MergeSharesStateMappable {
  final int sharesCount;
  final Map<int, String> shares;
  final AppError? error;
  final Uint8List? secret;

  MergeSharesState({
    this.sharesCount = 0,
    this.shares = const {},
    this.error,
    this.secret,
  });
}
