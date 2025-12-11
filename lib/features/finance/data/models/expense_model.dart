import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required String id, // Firestore ID
    required DateTime date, // tanggal
    required String category, // kategori
    required String description, // deskripsi
    required double amount, // jumlah
    required String paidTo, // dibayarKe
    required String paymentMethod, // metodeBayar
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}
