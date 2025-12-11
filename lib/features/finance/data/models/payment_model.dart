import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required String id, // Firestore ID
    required String billId, // tagihanId
    required DateTime paymentDate, // tglBayar
    required double amount, // jumlahBayar
    required String method, // metodeBayar
    String? reference, // referensi
    String? notes, // catatan
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
