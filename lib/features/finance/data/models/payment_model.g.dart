// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      id: json['id'] as String,
      billId: json['billId'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'billId': instance.billId,
      'paymentDate': instance.paymentDate.toIso8601String(),
      'amount': instance.amount,
      'method': instance.method,
      'reference': instance.reference,
      'notes': instance.notes,
    };
