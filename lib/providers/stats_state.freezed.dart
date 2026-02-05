// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatsState {
  UserStats? get stats => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of StatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatsStateCopyWith<StatsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsStateCopyWith<$Res> {
  factory $StatsStateCopyWith(
          StatsState value, $Res Function(StatsState) then) =
      _$StatsStateCopyWithImpl<$Res, StatsState>;
  @useResult
  $Res call({UserStats? stats, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$StatsStateCopyWithImpl<$Res, $Val extends StatsState>
    implements $StatsStateCopyWith<$Res> {
  _$StatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatsStateImplCopyWith<$Res>
    implements $StatsStateCopyWith<$Res> {
  factory _$$StatsStateImplCopyWith(
          _$StatsStateImpl value, $Res Function(_$StatsStateImpl) then) =
      __$$StatsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserStats? stats, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$$StatsStateImplCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsStateImpl>
    implements _$$StatsStateImplCopyWith<$Res> {
  __$$StatsStateImplCopyWithImpl(
      _$StatsStateImpl _value, $Res Function(_$StatsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$StatsStateImpl(
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StatsStateImpl implements _StatsState {
  const _$StatsStateImpl(
      {this.stats, this.isLoading = false, this.errorMessage});

  @override
  final UserStats? stats;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'StatsState(stats: $stats, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsStateImpl &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats, isLoading, errorMessage);

  /// Create a copy of StatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsStateImplCopyWith<_$StatsStateImpl> get copyWith =>
      __$$StatsStateImplCopyWithImpl<_$StatsStateImpl>(this, _$identity);
}

abstract class _StatsState implements StatsState {
  const factory _StatsState(
      {final UserStats? stats,
      final bool isLoading,
      final String? errorMessage}) = _$StatsStateImpl;

  @override
  UserStats? get stats;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of StatsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatsStateImplCopyWith<_$StatsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
