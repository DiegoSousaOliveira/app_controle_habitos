// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HabitState {
  List<Habit> get habits => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of HabitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitStateCopyWith<HabitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitStateCopyWith<$Res> {
  factory $HabitStateCopyWith(
          HabitState value, $Res Function(HabitState) then) =
      _$HabitStateCopyWithImpl<$Res, HabitState>;
  @useResult
  $Res call({List<Habit> habits, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$HabitStateCopyWithImpl<$Res, $Val extends HabitState>
    implements $HabitStateCopyWith<$Res> {
  _$HabitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habits = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      habits: null == habits
          ? _value.habits
          : habits // ignore: cast_nullable_to_non_nullable
              as List<Habit>,
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
abstract class _$$HabitStateImplCopyWith<$Res>
    implements $HabitStateCopyWith<$Res> {
  factory _$$HabitStateImplCopyWith(
          _$HabitStateImpl value, $Res Function(_$HabitStateImpl) then) =
      __$$HabitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Habit> habits, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$$HabitStateImplCopyWithImpl<$Res>
    extends _$HabitStateCopyWithImpl<$Res, _$HabitStateImpl>
    implements _$$HabitStateImplCopyWith<$Res> {
  __$$HabitStateImplCopyWithImpl(
      _$HabitStateImpl _value, $Res Function(_$HabitStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habits = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$HabitStateImpl(
      habits: null == habits
          ? _value._habits
          : habits // ignore: cast_nullable_to_non_nullable
              as List<Habit>,
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

class _$HabitStateImpl implements _HabitState {
  const _$HabitStateImpl(
      {final List<Habit> habits = const [],
      this.isLoading = false,
      this.errorMessage})
      : _habits = habits;

  final List<Habit> _habits;
  @override
  @JsonKey()
  List<Habit> get habits {
    if (_habits is EqualUnmodifiableListView) return _habits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_habits);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'HabitState(habits: $habits, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitStateImpl &&
            const DeepCollectionEquality().equals(other._habits, _habits) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_habits), isLoading, errorMessage);

  /// Create a copy of HabitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitStateImplCopyWith<_$HabitStateImpl> get copyWith =>
      __$$HabitStateImplCopyWithImpl<_$HabitStateImpl>(this, _$identity);
}

abstract class _HabitState implements HabitState {
  const factory _HabitState(
      {final List<Habit> habits,
      final bool isLoading,
      final String? errorMessage}) = _$HabitStateImpl;

  @override
  List<Habit> get habits;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of HabitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitStateImplCopyWith<_$HabitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
