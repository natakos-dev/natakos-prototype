// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoomTypeModel _$RoomTypeModelFromJson(Map<String, dynamic> json) {
  return _RoomTypeModel.fromJson(json);
}

/// @nodoc
mixin _$RoomTypeModel {
  String get id => throw _privateConstructorUsedError; // Firestore ID
  String get name => throw _privateConstructorUsedError; // namaTipe
  double get monthlyPrice => throw _privateConstructorUsedError; // tarifBulanan
  String? get description => throw _privateConstructorUsedError; // keterangan
  String get paymentScheme =>
      throw _privateConstructorUsedError; // 'Bulanan', 'Mingguan', 'Tahunan'
  List<String> get facilities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomTypeModelCopyWith<RoomTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomTypeModelCopyWith<$Res> {
  factory $RoomTypeModelCopyWith(
          RoomTypeModel value, $Res Function(RoomTypeModel) then) =
      _$RoomTypeModelCopyWithImpl<$Res, RoomTypeModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      double monthlyPrice,
      String? description,
      String paymentScheme,
      List<String> facilities});
}

/// @nodoc
class _$RoomTypeModelCopyWithImpl<$Res, $Val extends RoomTypeModel>
    implements $RoomTypeModelCopyWith<$Res> {
  _$RoomTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? monthlyPrice = null,
    Object? description = freezed,
    Object? paymentScheme = null,
    Object? facilities = null,
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
      monthlyPrice: null == monthlyPrice
          ? _value.monthlyPrice
          : monthlyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentScheme: null == paymentScheme
          ? _value.paymentScheme
          : paymentScheme // ignore: cast_nullable_to_non_nullable
              as String,
      facilities: null == facilities
          ? _value.facilities
          : facilities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomTypeModelImplCopyWith<$Res>
    implements $RoomTypeModelCopyWith<$Res> {
  factory _$$RoomTypeModelImplCopyWith(
          _$RoomTypeModelImpl value, $Res Function(_$RoomTypeModelImpl) then) =
      __$$RoomTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double monthlyPrice,
      String? description,
      String paymentScheme,
      List<String> facilities});
}

/// @nodoc
class __$$RoomTypeModelImplCopyWithImpl<$Res>
    extends _$RoomTypeModelCopyWithImpl<$Res, _$RoomTypeModelImpl>
    implements _$$RoomTypeModelImplCopyWith<$Res> {
  __$$RoomTypeModelImplCopyWithImpl(
      _$RoomTypeModelImpl _value, $Res Function(_$RoomTypeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? monthlyPrice = null,
    Object? description = freezed,
    Object? paymentScheme = null,
    Object? facilities = null,
  }) {
    return _then(_$RoomTypeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      monthlyPrice: null == monthlyPrice
          ? _value.monthlyPrice
          : monthlyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentScheme: null == paymentScheme
          ? _value.paymentScheme
          : paymentScheme // ignore: cast_nullable_to_non_nullable
              as String,
      facilities: null == facilities
          ? _value._facilities
          : facilities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomTypeModelImpl implements _RoomTypeModel {
  const _$RoomTypeModelImpl(
      {required this.id,
      required this.name,
      required this.monthlyPrice,
      this.description,
      this.paymentScheme = 'Bulanan',
      final List<String> facilities = const []})
      : _facilities = facilities;

  factory _$RoomTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomTypeModelImplFromJson(json);

  @override
  final String id;
// Firestore ID
  @override
  final String name;
// namaTipe
  @override
  final double monthlyPrice;
// tarifBulanan
  @override
  final String? description;
// keterangan
  @override
  @JsonKey()
  final String paymentScheme;
// 'Bulanan', 'Mingguan', 'Tahunan'
  final List<String> _facilities;
// 'Bulanan', 'Mingguan', 'Tahunan'
  @override
  @JsonKey()
  List<String> get facilities {
    if (_facilities is EqualUnmodifiableListView) return _facilities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_facilities);
  }

  @override
  String toString() {
    return 'RoomTypeModel(id: $id, name: $name, monthlyPrice: $monthlyPrice, description: $description, paymentScheme: $paymentScheme, facilities: $facilities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomTypeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.monthlyPrice, monthlyPrice) ||
                other.monthlyPrice == monthlyPrice) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.paymentScheme, paymentScheme) ||
                other.paymentScheme == paymentScheme) &&
            const DeepCollectionEquality()
                .equals(other._facilities, _facilities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      monthlyPrice,
      description,
      paymentScheme,
      const DeepCollectionEquality().hash(_facilities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomTypeModelImplCopyWith<_$RoomTypeModelImpl> get copyWith =>
      __$$RoomTypeModelImplCopyWithImpl<_$RoomTypeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomTypeModelImplToJson(
      this,
    );
  }
}

abstract class _RoomTypeModel implements RoomTypeModel {
  const factory _RoomTypeModel(
      {required final String id,
      required final String name,
      required final double monthlyPrice,
      final String? description,
      final String paymentScheme,
      final List<String> facilities}) = _$RoomTypeModelImpl;

  factory _RoomTypeModel.fromJson(Map<String, dynamic> json) =
      _$RoomTypeModelImpl.fromJson;

  @override
  String get id;
  @override // Firestore ID
  String get name;
  @override // namaTipe
  double get monthlyPrice;
  @override // tarifBulanan
  String? get description;
  @override // keterangan
  String get paymentScheme;
  @override // 'Bulanan', 'Mingguan', 'Tahunan'
  List<String> get facilities;
  @override
  @JsonKey(ignore: true)
  _$$RoomTypeModelImplCopyWith<_$RoomTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
