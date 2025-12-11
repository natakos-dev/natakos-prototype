// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'penghuni.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Penghuni {
  String get id => throw _privateConstructorUsedError;
  String get nama => throw _privateConstructorUsedError;
  String get noHp => throw _privateConstructorUsedError;
  String get nik => throw _privateConstructorUsedError;
  String? get fotoKtpUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PenghuniCopyWith<Penghuni> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PenghuniCopyWith<$Res> {
  factory $PenghuniCopyWith(Penghuni value, $Res Function(Penghuni) then) =
      _$PenghuniCopyWithImpl<$Res, Penghuni>;
  @useResult
  $Res call(
      {String id,
      String nama,
      String noHp,
      String nik,
      String? fotoKtpUrl,
      String status,
      DateTime? createdAt});
}

/// @nodoc
class _$PenghuniCopyWithImpl<$Res, $Val extends Penghuni>
    implements $PenghuniCopyWith<$Res> {
  _$PenghuniCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = null,
    Object? noHp = null,
    Object? nik = null,
    Object? fotoKtpUrl = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      noHp: null == noHp
          ? _value.noHp
          : noHp // ignore: cast_nullable_to_non_nullable
              as String,
      nik: null == nik
          ? _value.nik
          : nik // ignore: cast_nullable_to_non_nullable
              as String,
      fotoKtpUrl: freezed == fotoKtpUrl
          ? _value.fotoKtpUrl
          : fotoKtpUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PenghuniImplCopyWith<$Res>
    implements $PenghuniCopyWith<$Res> {
  factory _$$PenghuniImplCopyWith(
          _$PenghuniImpl value, $Res Function(_$PenghuniImpl) then) =
      __$$PenghuniImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nama,
      String noHp,
      String nik,
      String? fotoKtpUrl,
      String status,
      DateTime? createdAt});
}

/// @nodoc
class __$$PenghuniImplCopyWithImpl<$Res>
    extends _$PenghuniCopyWithImpl<$Res, _$PenghuniImpl>
    implements _$$PenghuniImplCopyWith<$Res> {
  __$$PenghuniImplCopyWithImpl(
      _$PenghuniImpl _value, $Res Function(_$PenghuniImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nama = null,
    Object? noHp = null,
    Object? nik = null,
    Object? fotoKtpUrl = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$PenghuniImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _value.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      noHp: null == noHp
          ? _value.noHp
          : noHp // ignore: cast_nullable_to_non_nullable
              as String,
      nik: null == nik
          ? _value.nik
          : nik // ignore: cast_nullable_to_non_nullable
              as String,
      fotoKtpUrl: freezed == fotoKtpUrl
          ? _value.fotoKtpUrl
          : fotoKtpUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$PenghuniImpl implements _Penghuni {
  const _$PenghuniImpl(
      {required this.id,
      required this.nama,
      required this.noHp,
      required this.nik,
      this.fotoKtpUrl,
      this.status = 'Calon',
      this.createdAt});

  @override
  final String id;
  @override
  final String nama;
  @override
  final String noHp;
  @override
  final String nik;
  @override
  final String? fotoKtpUrl;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Penghuni(id: $id, nama: $nama, noHp: $noHp, nik: $nik, fotoKtpUrl: $fotoKtpUrl, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenghuniImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.noHp, noHp) || other.noHp == noHp) &&
            (identical(other.nik, nik) || other.nik == nik) &&
            (identical(other.fotoKtpUrl, fotoKtpUrl) ||
                other.fotoKtpUrl == fotoKtpUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, nama, noHp, nik, fotoKtpUrl, status, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenghuniImplCopyWith<_$PenghuniImpl> get copyWith =>
      __$$PenghuniImplCopyWithImpl<_$PenghuniImpl>(this, _$identity);
}

abstract class _Penghuni implements Penghuni {
  const factory _Penghuni(
      {required final String id,
      required final String nama,
      required final String noHp,
      required final String nik,
      final String? fotoKtpUrl,
      final String status,
      final DateTime? createdAt}) = _$PenghuniImpl;

  @override
  String get id;
  @override
  String get nama;
  @override
  String get noHp;
  @override
  String get nik;
  @override
  String? get fotoKtpUrl;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PenghuniImplCopyWith<_$PenghuniImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
