// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractModelImpl _$$ContractModelImplFromJson(Map<String, dynamic> json) =>
    _$ContractModelImpl(
      id: json['id'] as String,
      tenantId: json['tenantId'] as String,
      roomId: json['roomId'] as String,
      entryDate: DateTime.parse(json['entryDate'] as String),
      plannedExitDate: json['plannedExitDate'] == null
          ? null
          : DateTime.parse(json['plannedExitDate'] as String),
      actualExitDate: json['actualExitDate'] == null
          ? null
          : DateTime.parse(json['actualExitDate'] as String),
      monthlyRate: (json['monthlyRate'] as num).toDouble(),
      status: json['status'] as String? ?? 'Active',
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ContractModelImplToJson(_$ContractModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'roomId': instance.roomId,
      'entryDate': instance.entryDate.toIso8601String(),
      'plannedExitDate': instance.plannedExitDate?.toIso8601String(),
      'actualExitDate': instance.actualExitDate?.toIso8601String(),
      'monthlyRate': instance.monthlyRate,
      'status': instance.status,
      'notes': instance.notes,
    };
