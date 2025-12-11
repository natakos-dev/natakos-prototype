import 'package:freezed_annotation/freezed_annotation.dart';

part 'contract_model.freezed.dart';
part 'contract_model.g.dart';

@freezed
class ContractModel with _$ContractModel {
  const factory ContractModel({
    required String id, // Firestore ID
    required String tenantId, // penghuniId (Reference)
    required String roomId, // kamarId (Reference)
    required DateTime entryDate, // tglMasuk
    DateTime? plannedExitDate, // tglKeluarRencana
    DateTime? actualExitDate, // tglKeluarReal
    required double monthlyRate, // tarifBulanan
    @Default('Active')
    String status, // statusKontrak: 'Active', 'Finished', 'Canceled'
    String? notes, // catatan
  }) = _ContractModel;

  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);
}
