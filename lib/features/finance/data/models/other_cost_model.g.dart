// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_cost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtherCostModelImpl _$$OtherCostModelImplFromJson(Map<String, dynamic> json) =>
    _$OtherCostModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      defaultAmount: (json['defaultAmount'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$OtherCostModelImplToJson(
        _$OtherCostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'defaultAmount': instance.defaultAmount,
      'isActive': instance.isActive,
    };
