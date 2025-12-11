// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return _RoomModel.fromJson(json);
}

/// @nodoc
mixin _$RoomModel {
  String get id => throw _privateConstructorUsedError; // Firestore ID
  String get roomNumber => throw _privateConstructorUsedError; // kodeKamar
  int get floor => throw _privateConstructorUsedError; // lantai
  bool get isActive => throw _privateConstructorUsedError; // aktif
  String get roomTypeId =>
      throw _privateConstructorUsedError; // tipeKamarId (Reference)
// Flattened/Joined fields for UI convenience (optional, or handle in repository)
  String? get currentTenantName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomModelCopyWith<RoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomModelCopyWith<$Res> {
  factory $RoomModelCopyWith(RoomModel value, $Res Function(RoomModel) then) =
      _$RoomModelCopyWithImpl<$Res, RoomModel>;
  @useResult
  $Res call(
      {String id,
      String roomNumber,
      int floor,
      bool isActive,
      String roomTypeId,
      String? currentTenantName,
      String status});
}

/// @nodoc
class _$RoomModelCopyWithImpl<$Res, $Val extends RoomModel>
    implements $RoomModelCopyWith<$Res> {
  _$RoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomNumber = null,
    Object? floor = null,
    Object? isActive = null,
    Object? roomTypeId = null,
    Object? currentTenantName = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      roomTypeId: null == roomTypeId
          ? _value.roomTypeId
          : roomTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      currentTenantName: freezed == currentTenantName
          ? _value.currentTenantName
          : currentTenantName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomModelImplCopyWith<$Res>
    implements $RoomModelCopyWith<$Res> {
  factory _$$RoomModelImplCopyWith(
          _$RoomModelImpl value, $Res Function(_$RoomModelImpl) then) =
      __$$RoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roomNumber,
      int floor,
      bool isActive,
      String roomTypeId,
      String? currentTenantName,
      String status});
}

/// @nodoc
class __$$RoomModelImplCopyWithImpl<$Res>
    extends _$RoomModelCopyWithImpl<$Res, _$RoomModelImpl>
    implements _$$RoomModelImplCopyWith<$Res> {
  __$$RoomModelImplCopyWithImpl(
      _$RoomModelImpl _value, $Res Function(_$RoomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomNumber = null,
    Object? floor = null,
    Object? isActive = null,
    Object? roomTypeId = null,
    Object? currentTenantName = freezed,
    Object? status = null,
  }) {
    return _then(_$RoomModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      roomTypeId: null == roomTypeId
          ? _value.roomTypeId
          : roomTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      currentTenantName: freezed == currentTenantName
          ? _value.currentTenantName
          : currentTenantName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomModelImpl implements _RoomModel {
  const _$RoomModelImpl(
      {required this.id,
      required this.roomNumber,
      required this.floor,
      this.isActive = true,
      required this.roomTypeId,
      this.currentTenantName,
      this.status = 'Kosong'});

  factory _$RoomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomModelImplFromJson(json);

  @override
  final String id;
// Firestore ID
  @override
  final String roomNumber;
// kodeKamar
  @override
  final int floor;
// lantai
  @override
  @JsonKey()
  final bool isActive;
// aktif
  @override
  final String roomTypeId;
// tipeKamarId (Reference)
// Flattened/Joined fields for UI convenience (optional, or handle in repository)
  @override
  final String? currentTenantName;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'RoomModel(id: $id, roomNumber: $roomNumber, floor: $floor, isActive: $isActive, roomTypeId: $roomTypeId, currentTenantName: $currentTenantName, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.roomTypeId, roomTypeId) ||
                other.roomTypeId == roomTypeId) &&
            (identical(other.currentTenantName, currentTenantName) ||
                other.currentTenantName == currentTenantName) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, roomNumber, floor, isActive,
      roomTypeId, currentTenantName, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomModelImplCopyWith<_$RoomModelImpl> get copyWith =>
      __$$RoomModelImplCopyWithImpl<_$RoomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomModelImplToJson(
      this,
    );
  }
}

abstract class _RoomModel implements RoomModel {
  const factory _RoomModel(
      {required final String id,
      required final String roomNumber,
      required final int floor,
      final bool isActive,
      required final String roomTypeId,
      final String? currentTenantName,
      final String status}) = _$RoomModelImpl;

  factory _RoomModel.fromJson(Map<String, dynamic> json) =
      _$RoomModelImpl.fromJson;

  @override
  String get id;
  @override // Firestore ID
  String get roomNumber;
  @override // kodeKamar
  int get floor;
  @override // lantai
  bool get isActive;
  @override // aktif
  String get roomTypeId;
  @override // tipeKamarId (Reference)
// Flattened/Joined fields for UI convenience (optional, or handle in repository)
  String? get currentTenantName;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$RoomModelImplCopyWith<_$RoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
