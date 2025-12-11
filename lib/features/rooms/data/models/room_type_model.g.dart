// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomTypeModelImpl _$$RoomTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$RoomTypeModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      description: json['description'] as String?,
      paymentScheme: json['paymentScheme'] as String? ?? 'Bulanan',
      facilities: (json['facilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RoomTypeModelImplToJson(_$RoomTypeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'monthlyPrice': instance.monthlyPrice,
      'description': instance.description,
      'paymentScheme': instance.paymentScheme,
      'facilities': instance.facilities,
    };
