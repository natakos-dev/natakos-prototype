import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_cost_model.freezed.dart';
part 'other_cost_model.g.dart';

@freezed
class OtherCostModel with _$OtherCostModel {
  const factory OtherCostModel({
    required String id, // Firestore ID
    required String name, // namaBiaya
    required String type, // tipe (e.g. 'OneTime', 'Monthly')
    required double defaultAmount, // tarifDefault
    @Default(true) bool isActive, // aktif
  }) = _OtherCostModel;

  factory OtherCostModel.fromJson(Map<String, dynamic> json) =>
      _$OtherCostModelFromJson(json);
}
