// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillItemModelImpl _$$BillItemModelImplFromJson(Map<String, dynamic> json) =>
    _$BillItemModelImpl(
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      otherCostId: json['otherCostId'] as String?,
    );

Map<String, dynamic> _$$BillItemModelImplToJson(_$BillItemModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
      'otherCostId': instance.otherCostId,
    };

_$BillModelImpl _$$BillModelImplFromJson(Map<String, dynamic> json) =>
    _$BillModelImpl(
      id: json['id'] as String,
      contractId: json['contractId'] as String,
      period: DateTime.parse(json['period'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String? ?? 'Unpaid',
      items: (json['items'] as List<dynamic>)
          .map((e) => BillItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$BillModelImplToJson(_$BillModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractId': instance.contractId,
      'period': instance.period.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'items': instance.items,
      'notes': instance.notes,
    };
