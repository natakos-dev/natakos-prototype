// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      description: json['description'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      relatedId: json['relatedId'] as String?,
      relatedName: json['relatedName'] as String?,
      relatedType: json['relatedType'] as String?,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'description': instance.description,
      'paymentMethod': instance.paymentMethod,
      'relatedId': instance.relatedId,
      'relatedName': instance.relatedName,
      'relatedType': instance.relatedType,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};
