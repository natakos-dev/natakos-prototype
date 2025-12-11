import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill_model.freezed.dart';
part 'bill_model.g.dart';

@freezed
class BillItemModel with _$BillItemModel {
  const factory BillItemModel({
    required String description, // deskripsi
    required int quantity, // qty
    required double price, // hargaSatuan
    required double total, // subtotal
    String? otherCostId, // biayaLainId (Nullable)
  }) = _BillItemModel; // Maps to DetailTagihan items

  factory BillItemModel.fromJson(Map<String, dynamic> json) =>
      _$BillItemModelFromJson(json);
}

@freezed
class BillModel with _$BillModel {
  const factory BillModel({
    required String id, // Firestore ID
    required String contractId, // kontrakId
    required DateTime period, // periode (Month-Year)
    required DateTime dueDate, // tglJatuhTempo
    required double totalAmount, // totalTagihan
    @Default('Unpaid')
    String status, // statusBayar: 'Unpaid', 'Paid', 'Partial'
    required List<BillItemModel> items, // embedded DetailTagihan
    String? notes, // catatan
  }) = _BillModel;

  factory BillModel.fromJson(Map<String, dynamic> json) =>
      _$BillModelFromJson(json);
}
