// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantModelImpl _$$TenantModelImplFromJson(Map<String, dynamic> json) =>
    _$TenantModelImpl(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      nik: json['nik'] as String,
      originAddress: json['originAddress'] as String,
      occupation: json['occupation'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      notes: json['notes'] as String?,
      entryDate: json['entryDate'] as String?,
      nextDueDate: json['nextDueDate'] as String?,
    );

Map<String, dynamic> _$$TenantModelImplToJson(_$TenantModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'nik': instance.nik,
      'originAddress': instance.originAddress,
      'occupation': instance.occupation,
      'placeOfBirth': instance.placeOfBirth,
      'dateOfBirth': instance.dateOfBirth,
      'emergencyContact': instance.emergencyContact,
      'notes': instance.notes,
      'entryDate': instance.entryDate,
      'nextDueDate': instance.nextDueDate,
    };
