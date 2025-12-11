// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContractModel _$ContractModelFromJson(Map<String, dynamic> json) {
  return _ContractModel.fromJson(json);
}

/// @nodoc
mixin _$ContractModel {
  String get id => throw _privateConstructorUsedError; // Firestore ID
  String get tenantId =>
      throw _privateConstructorUsedError; // penghuniId (Reference)
  String get roomId =>
      throw _privateConstructorUsedError; // kamarId (Reference)
  DateTime get entryDate => throw _privateConstructorUsedError; // tglMasuk
  DateTime? get plannedExitDate =>
      throw _privateConstructorUsedError; // tglKeluarRencana
  DateTime? get actualExitDate =>
      throw _privateConstructorUsedError; // tglKeluarReal
  double get monthlyRate => throw _privateConstructorUsedError; // tarifBulanan
  String get status =>
      throw _privateConstructorUsedError; // statusKontrak: 'Active', 'Finished', 'Canceled'
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContractModelCopyWith<ContractModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractModelCopyWith<$Res> {
  factory $ContractModelCopyWith(
          ContractModel value, $Res Function(ContractModel) then) =
      _$ContractModelCopyWithImpl<$Res, ContractModel>;
  @useResult
  $Res call(
      {String id,
      String tenantId,
      String roomId,
      DateTime entryDate,
      DateTime? plannedExitDate,
      DateTime? actualExitDate,
      double monthlyRate,
      String status,
      String? notes});
}

/// @nodoc
class _$ContractModelCopyWithImpl<$Res, $Val extends ContractModel>
    implements $ContractModelCopyWith<$Res> {
  _$ContractModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tenantId = null,
    Object? roomId = null,
    Object? entryDate = null,
    Object? plannedExitDate = freezed,
    Object? actualExitDate = freezed,
    Object? monthlyRate = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: null == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      entryDate: null == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedExitDate: freezed == plannedExitDate
          ? _value.plannedExitDate
          : plannedExitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualExitDate: freezed == actualExitDate
          ? _value.actualExitDate
          : actualExitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      monthlyRate: null == monthlyRate
          ? _value.monthlyRate
          : monthlyRate // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContractModelImplCopyWith<$Res>
    implements $ContractModelCopyWith<$Res> {
  factory _$$ContractModelImplCopyWith(
          _$ContractModelImpl value, $Res Function(_$ContractModelImpl) then) =
      __$$ContractModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String tenantId,
      String roomId,
      DateTime entryDate,
      DateTime? plannedExitDate,
      DateTime? actualExitDate,
      double monthlyRate,
      String status,
      String? notes});
}

/// @nodoc
class __$$ContractModelImplCopyWithImpl<$Res>
    extends _$ContractModelCopyWithImpl<$Res, _$ContractModelImpl>
    implements _$$ContractModelImplCopyWith<$Res> {
  __$$ContractModelImplCopyWithImpl(
      _$ContractModelImpl _value, $Res Function(_$ContractModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tenantId = null,
    Object? roomId = null,
    Object? entryDate = null,
    Object? plannedExitDate = freezed,
    Object? actualExitDate = freezed,
    Object? monthlyRate = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_$ContractModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: null == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      entryDate: null == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedExitDate: freezed == plannedExitDate
          ? _value.plannedExitDate
          : plannedExitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      actualExitDate: freezed == actualExitDate
          ? _value.actualExitDate
          : actualExitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      monthlyRate: null == monthlyRate
          ? _value.monthlyRate
          : monthlyRate // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractModelImpl implements _ContractModel {
  const _$ContractModelImpl(
      {required this.id,
      required this.tenantId,
      required this.roomId,
      required this.entryDate,
      this.plannedExitDate,
      this.actualExitDate,
      required this.monthlyRate,
      this.status = 'Active',
      this.notes});

  factory _$ContractModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractModelImplFromJson(json);

  @override
  final String id;
// Firestore ID
  @override
  final String tenantId;
// penghuniId (Reference)
  @override
  final String roomId;
// kamarId (Reference)
  @override
  final DateTime entryDate;
// tglMasuk
  @override
  final DateTime? plannedExitDate;
// tglKeluarRencana
  @override
  final DateTime? actualExitDate;
// tglKeluarReal
  @override
  final double monthlyRate;
// tarifBulanan
  @override
  @JsonKey()
  final String status;
// statusKontrak: 'Active', 'Finished', 'Canceled'
  @override
  final String? notes;

  @override
  String toString() {
    return 'ContractModel(id: $id, tenantId: $tenantId, roomId: $roomId, entryDate: $entryDate, plannedExitDate: $plannedExitDate, actualExitDate: $actualExitDate, monthlyRate: $monthlyRate, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.plannedExitDate, plannedExitDate) ||
                other.plannedExitDate == plannedExitDate) &&
            (identical(other.actualExitDate, actualExitDate) ||
                other.actualExitDate == actualExitDate) &&
            (identical(other.monthlyRate, monthlyRate) ||
                other.monthlyRate == monthlyRate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, tenantId, roomId, entryDate,
      plannedExitDate, actualExitDate, monthlyRate, status, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractModelImplCopyWith<_$ContractModelImpl> get copyWith =>
      __$$ContractModelImplCopyWithImpl<_$ContractModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractModelImplToJson(
      this,
    );
  }
}

abstract class _ContractModel implements ContractModel {
  const factory _ContractModel(
      {required final String id,
      required final String tenantId,
      required final String roomId,
      required final DateTime entryDate,
      final DateTime? plannedExitDate,
      final DateTime? actualExitDate,
      required final double monthlyRate,
      final String status,
      final String? notes}) = _$ContractModelImpl;

  factory _ContractModel.fromJson(Map<String, dynamic> json) =
      _$ContractModelImpl.fromJson;

  @override
  String get id;
  @override // Firestore ID
  String get tenantId;
  @override // penghuniId (Reference)
  String get roomId;
  @override // kamarId (Reference)
  DateTime get entryDate;
  @override // tglMasuk
  DateTime? get plannedExitDate;
  @override // tglKeluarRencana
  DateTime? get actualExitDate;
  @override // tglKeluarReal
  double get monthlyRate;
  @override // tarifBulanan
  String get status;
  @override // statusKontrak: 'Active', 'Finished', 'Canceled'
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$ContractModelImplCopyWith<_$ContractModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
