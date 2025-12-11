// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomModelImpl _$$RoomModelImplFromJson(Map<String, dynamic> json) =>
    _$RoomModelImpl(
      id: json['id'] as String,
      roomNumber: json['roomNumber'] as String,
      floor: (json['floor'] as num).toInt(),
      isActive: json['isActive'] as bool? ?? true,
      roomTypeId: json['roomTypeId'] as String,
      currentTenantName: json['currentTenantName'] as String?,
      status: json['status'] as String? ?? 'Kosong',
    );

Map<String, dynamic> _$$RoomModelImplToJson(_$RoomModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomNumber': instance.roomNumber,
      'floor': instance.floor,
      'isActive': instance.isActive,
      'roomTypeId': instance.roomTypeId,
      'currentTenantName': instance.currentTenantName,
      'status': instance.status,
    };
