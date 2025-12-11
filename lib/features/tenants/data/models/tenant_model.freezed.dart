// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TenantModel _$TenantModelFromJson(Map<String, dynamic> json) {
  return _TenantModel.fromJson(json);
}

/// @nodoc
mixin _$TenantModel {
  String get id => throw _privateConstructorUsedError; // Firestore ID
  String get fullName => throw _privateConstructorUsedError; // namaLengkap
  String get phoneNumber => throw _privateConstructorUsedError; // noHp
  String get nik => throw _privateConstructorUsedError; // nik
  String get originAddress => throw _privateConstructorUsedError; // alamatAsal
  String? get occupation => throw _privateConstructorUsedError; // pekerjaan
  String? get placeOfBirth =>
      throw _privateConstructorUsedError; // Tempat Lahir
  String? get dateOfBirth =>
      throw _privateConstructorUsedError; // Tanggal Lahir
  String? get emergencyContact =>
      throw _privateConstructorUsedError; // kontakDarurat
  String? get notes => throw _privateConstructorUsedError; // catatan
  String? get entryDate =>
      throw _privateConstructorUsedError; // Tanggal Masuk (ISO 8601 YYYY-MM-DD)
  String? get nextDueDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TenantModelCopyWith<TenantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantModelCopyWith<$Res> {
  factory $TenantModelCopyWith(
          TenantModel value, $Res Function(TenantModel) then) =
      _$TenantModelCopyWithImpl<$Res, TenantModel>;
  @useResult
  $Res call(
      {String id,
      String fullName,
      String phoneNumber,
      String nik,
      String originAddress,
      String? occupation,
      String? placeOfBirth,
      String? dateOfBirth,
      String? emergencyContact,
      String? notes,
      String? entryDate,
      String? nextDueDate});
}

/// @nodoc
class _$TenantModelCopyWithImpl<$Res, $Val extends TenantModel>
    implements $TenantModelCopyWith<$Res> {
  _$TenantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? nik = null,
    Object? originAddress = null,
    Object? occupation = freezed,
    Object? placeOfBirth = freezed,
    Object? dateOfBirth = freezed,
    Object? emergencyContact = freezed,
    Object? notes = freezed,
    Object? entryDate = freezed,
    Object? nextDueDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      nik: null == nik
          ? _value.nik
          : nik // ignore: cast_nullable_to_non_nullable
              as String,
      originAddress: null == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String,
      occupation: freezed == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String?,
      placeOfBirth: freezed == placeOfBirth
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      entryDate: freezed == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      nextDueDate: freezed == nextDueDate
          ? _value.nextDueDate
          : nextDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TenantModelImplCopyWith<$Res>
    implements $TenantModelCopyWith<$Res> {
  factory _$$TenantModelImplCopyWith(
          _$TenantModelImpl value, $Res Function(_$TenantModelImpl) then) =
      __$$TenantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fullName,
      String phoneNumber,
      String nik,
      String originAddress,
      String? occupation,
      String? placeOfBirth,
      String? dateOfBirth,
      String? emergencyContact,
      String? notes,
      String? entryDate,
      String? nextDueDate});
}

/// @nodoc
class __$$TenantModelImplCopyWithImpl<$Res>
    extends _$TenantModelCopyWithImpl<$Res, _$TenantModelImpl>
    implements _$$TenantModelImplCopyWith<$Res> {
  __$$TenantModelImplCopyWithImpl(
      _$TenantModelImpl _value, $Res Function(_$TenantModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? nik = null,
    Object? originAddress = null,
    Object? occupation = freezed,
    Object? placeOfBirth = freezed,
    Object? dateOfBirth = freezed,
    Object? emergencyContact = freezed,
    Object? notes = freezed,
    Object? entryDate = freezed,
    Object? nextDueDate = freezed,
  }) {
    return _then(_$TenantModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      nik: null == nik
          ? _value.nik
          : nik // ignore: cast_nullable_to_non_nullable
              as String,
      originAddress: null == originAddress
          ? _value.originAddress
          : originAddress // ignore: cast_nullable_to_non_nullable
              as String,
      occupation: freezed == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String?,
      placeOfBirth: freezed == placeOfBirth
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      entryDate: freezed == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      nextDueDate: freezed == nextDueDate
          ? _value.nextDueDate
          : nextDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantModelImpl implements _TenantModel {
  const _$TenantModelImpl(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.nik,
      required this.originAddress,
      this.occupation,
      this.placeOfBirth,
      this.dateOfBirth,
      this.emergencyContact,
      this.notes,
      this.entryDate,
      this.nextDueDate});

  factory _$TenantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantModelImplFromJson(json);

  @override
  final String id;
// Firestore ID
  @override
  final String fullName;
// namaLengkap
  @override
  final String phoneNumber;
// noHp
  @override
  final String nik;
// nik
  @override
  final String originAddress;
// alamatAsal
  @override
  final String? occupation;
// pekerjaan
  @override
  final String? placeOfBirth;
// Tempat Lahir
  @override
  final String? dateOfBirth;
// Tanggal Lahir
  @override
  final String? emergencyContact;
// kontakDarurat
  @override
  final String? notes;
// catatan
  @override
  final String? entryDate;
// Tanggal Masuk (ISO 8601 YYYY-MM-DD)
  @override
  final String? nextDueDate;

  @override
  String toString() {
    return 'TenantModel(id: $id, fullName: $fullName, phoneNumber: $phoneNumber, nik: $nik, originAddress: $originAddress, occupation: $occupation, placeOfBirth: $placeOfBirth, dateOfBirth: $dateOfBirth, emergencyContact: $emergencyContact, notes: $notes, entryDate: $entryDate, nextDueDate: $nextDueDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.nik, nik) || other.nik == nik) &&
            (identical(other.originAddress, originAddress) ||
                other.originAddress == originAddress) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.placeOfBirth, placeOfBirth) ||
                other.placeOfBirth == placeOfBirth) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      phoneNumber,
      nik,
      originAddress,
      occupation,
      placeOfBirth,
      dateOfBirth,
      emergencyContact,
      notes,
      entryDate,
      nextDueDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantModelImplCopyWith<_$TenantModelImpl> get copyWith =>
      __$$TenantModelImplCopyWithImpl<_$TenantModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantModelImplToJson(
      this,
    );
  }
}

abstract class _TenantModel implements TenantModel {
  const factory _TenantModel(
      {required final String id,
      required final String fullName,
      required final String phoneNumber,
      required final String nik,
      required final String originAddress,
      final String? occupation,
      final String? placeOfBirth,
      final String? dateOfBirth,
      final String? emergencyContact,
      final String? notes,
      final String? entryDate,
      final String? nextDueDate}) = _$TenantModelImpl;

  factory _TenantModel.fromJson(Map<String, dynamic> json) =
      _$TenantModelImpl.fromJson;

  @override
  String get id;
  @override // Firestore ID
  String get fullName;
  @override // namaLengkap
  String get phoneNumber;
  @override // noHp
  String get nik;
  @override // nik
  String get originAddress;
  @override // alamatAsal
  String? get occupation;
  @override // pekerjaan
  String? get placeOfBirth;
  @override // Tempat Lahir
  String? get dateOfBirth;
  @override // Tanggal Lahir
  String? get emergencyContact;
  @override // kontakDarurat
  String? get notes;
  @override // catatan
  String? get entryDate;
  @override // Tanggal Masuk (ISO 8601 YYYY-MM-DD)
  String? get nextDueDate;
  @override
  @JsonKey(ignore: true)
  _$$TenantModelImplCopyWith<_$TenantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
