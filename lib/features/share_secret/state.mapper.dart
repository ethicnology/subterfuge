// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state.dart';

class ShareSecretStateMapper extends ClassMapperBase<ShareSecretState> {
  ShareSecretStateMapper._();

  static ShareSecretStateMapper? _instance;
  static ShareSecretStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShareSecretStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShareSecretState';

  static bool _$isLoading(ShareSecretState v) => v.isLoading;
  static const Field<ShareSecretState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: false,
  );
  static List<String> _$shares(ShareSecretState v) => v.shares;
  static const Field<ShareSecretState, List<String>> _f$shares = Field(
    'shares',
    _$shares,
    opt: true,
    def: const [],
  );
  static AppError? _$error(ShareSecretState v) => v.error;
  static const Field<ShareSecretState, AppError> _f$error = Field(
    'error',
    _$error,
    opt: true,
  );

  @override
  final MappableFields<ShareSecretState> fields = const {
    #isLoading: _f$isLoading,
    #shares: _f$shares,
    #error: _f$error,
  };

  static ShareSecretState _instantiate(DecodingData data) {
    return ShareSecretState(
      isLoading: data.dec(_f$isLoading),
      shares: data.dec(_f$shares),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShareSecretState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShareSecretState>(map);
  }

  static ShareSecretState fromJson(String json) {
    return ensureInitialized().decodeJson<ShareSecretState>(json);
  }
}

mixin ShareSecretStateMappable {
  String toJson() {
    return ShareSecretStateMapper.ensureInitialized()
        .encodeJson<ShareSecretState>(this as ShareSecretState);
  }

  Map<String, dynamic> toMap() {
    return ShareSecretStateMapper.ensureInitialized()
        .encodeMap<ShareSecretState>(this as ShareSecretState);
  }

  ShareSecretStateCopyWith<ShareSecretState, ShareSecretState, ShareSecretState>
  get copyWith =>
      _ShareSecretStateCopyWithImpl<ShareSecretState, ShareSecretState>(
        this as ShareSecretState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShareSecretStateMapper.ensureInitialized().stringifyValue(
      this as ShareSecretState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShareSecretStateMapper.ensureInitialized().equalsValue(
      this as ShareSecretState,
      other,
    );
  }

  @override
  int get hashCode {
    return ShareSecretStateMapper.ensureInitialized().hashValue(
      this as ShareSecretState,
    );
  }
}

extension ShareSecretStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShareSecretState, $Out> {
  ShareSecretStateCopyWith<$R, ShareSecretState, $Out>
  get $asShareSecretState =>
      $base.as((v, t, t2) => _ShareSecretStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShareSecretStateCopyWith<$R, $In extends ShareSecretState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get shares;
  $R call({bool? isLoading, List<String>? shares, AppError? error});
  ShareSecretStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShareSecretStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShareSecretState, $Out>
    implements ShareSecretStateCopyWith<$R, ShareSecretState, $Out> {
  _ShareSecretStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShareSecretState> $mapper =
      ShareSecretStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get shares =>
      ListCopyWith(
        $value.shares,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(shares: v),
      );
  @override
  $R call({bool? isLoading, List<String>? shares, Object? error = $none}) =>
      $apply(
        FieldCopyWithData({
          if (isLoading != null) #isLoading: isLoading,
          if (shares != null) #shares: shares,
          if (error != $none) #error: error,
        }),
      );
  @override
  ShareSecretState $make(CopyWithData data) => ShareSecretState(
    isLoading: data.get(#isLoading, or: $value.isLoading),
    shares: data.get(#shares, or: $value.shares),
    error: data.get(#error, or: $value.error),
  );

  @override
  ShareSecretStateCopyWith<$R2, ShareSecretState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShareSecretStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

