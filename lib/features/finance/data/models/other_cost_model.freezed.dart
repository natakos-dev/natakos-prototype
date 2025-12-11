// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_cost_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtherCostModel _$OtherCostModelFromJson(Map<String, dynamic> json) {
  return _OtherCostModel.fromJson(json);
}

/// @nodoc
mixin _$OtherCostModel {
  String get id => throw _privateConstructorUsedError; // Firestore ID
  String get name => throw _privateConstructorUsedError; // namaBiaya
  String get type =>
      throw _privateConstructorUsedError; // tipe (e.g. 'OneTime', 'Monthly')
  double get defaultAmount =>
      throw _privateConstructorUsedError; // tarifDefault
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtherCostModelCopyWith<OtherCostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherCostModelCopyWith<$Res> {
  factory $OtherCostModelCopyWith(
          OtherCostModel value, $Res Function(OtherCostModel) then) =
      _$OtherCostModelCopyWithImpl<$Res, OtherCostModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      double defaultAmount,
      bool isActive});
}

/// @nodoc
class _$OtherCostModelCopyWithImpl<$Res, $Val extends OtherCostModel>
    implements $OtherCostModelCopyWith<$Res> {
  _$OtherCostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? defaultAmount = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      defaultAmount: null == defaultAmount
          ? _value.defaultAmount
          : defaultAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtherCostModelImplCopyWith<$Res>
    implements $OtherCostModelCopyWith<$Res> {
  factory _$$OtherCostModelImplCopyWith(_$OtherCostModelImpl value,
          $Res Function(_$OtherCostModelImpl) then) =
      __$$OtherCostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      double defaultAmount,
      bool isActive});
}

/// @nodoc
class __$$OtherCostModelImplCopyWithImpl<$Res>
    extends _$OtherCostModelCopyWithImpl<$Res, _$OtherCostModelImpl>
    implements _$$OtherCostModelImplCopyWith<$Res> {
  __$$OtherCostModelImplCopyWithImpl(
      _$OtherCostModelImpl _value, $Res Function(_$OtherCostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? defaultAmount = null,
    Object? isActive = null,
  }) {
    return _then(_$OtherCostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      defaultAmount: null == defaultAmount
          ? _value.defaultAmount
          : defaultAmount // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtherCostModelImpl implements _OtherCostModel {
  const _$OtherCostModelImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.defaultAmount,
      this.isActive = true});

  factory _$OtherCostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherCostModelImplFromJson(json);

  @override
  final String id;
// Firestore ID
  @override
  final String name;
// namaBiaya
  @override
  final String type;
// tipe (e.g. 'OneTime', 'Monthly')
  @override
  final double defaultAmount;
// tarifDefault
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'OtherCostModel(id: $id, name: $name, type: $type, defaultAmount: $defaultAmount, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherCostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.defaultAmount, defaultAmount) ||
                other.defaultAmount == defaultAmount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, type, defaultAmount, isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherCostModelImplCopyWith<_$OtherCostModelImpl> get copyWith =>
      __$$OtherCostModelImplCopyWithImpl<_$OtherCostModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherCostModelImplToJson(
      this,
    );
  }
}

abstract class _OtherCostModel implements OtherCostModel {
  const factory _OtherCostModel(
      {required final String id,
      required final String name,
      required final String type,
      required final double defaultAmount,
      final bool isActive}) = _$OtherCostModelImpl;

  factory _OtherCostModel.fromJson(Map<String, dynamic> json) =
      _$OtherCostModelImpl.fromJson;

  @override
  String get id;
  @override // Firestore ID
  String get name;
  @override // namaBiaya
  String get type;
  @override // tipe (e.g. 'OneTime', 'Monthly')
  double get defaultAmount;
  @override // tarifDefault
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$OtherCostModelImplCopyWith<_$OtherCostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
