import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_model.freezed.dart';
part 'tenant_model.g.dart';

@freezed
class TenantModel with _$TenantModel {
  const factory TenantModel({
    required String id, // Firestore ID
    required String fullName, // namaLengkap
    required String phoneNumber, // noHp
    required String nik, // nik
    required String originAddress, // alamatAsal
    String? occupation, // pekerjaan
    String? placeOfBirth, // Tempat Lahir
    String? dateOfBirth, // Tanggal Lahir
    String? emergencyContact, // kontakDarurat
    String? notes, // catatan
    String? entryDate, // Tanggal Masuk (ISO 8601 YYYY-MM-DD)
    String? nextDueDate, // Jatuh Tempo Selanjutnya (ISO 8601 YYYY-MM-DD)
  }) = _TenantModel;

  factory TenantModel.fromJson(Map<String, dynamic> json) =>
      _$TenantModelFromJson(json);
}
