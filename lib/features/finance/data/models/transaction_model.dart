import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

enum TransactionType {
  @JsonValue('income')
  income,
  @JsonValue('expense')
  expense,
}

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required TransactionType type,
    required double amount,
    required DateTime date,
    required String category,
    String? description,
    required String paymentMethod,
    // Optional links to other entities
    String? relatedId, // e.g. tenantId or contractId
    String? relatedName, // e.g. Tenant Name
    String? relatedType, // 'tenant', 'contract', 'bill', etc.
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
