import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_type_model.freezed.dart';
part 'room_type_model.g.dart';

@freezed
class RoomTypeModel with _$RoomTypeModel {
  const factory RoomTypeModel({
    required String id, // Firestore ID
    required String name, // namaTipe
    required double monthlyPrice, // tarifBulanan
    String? description, // keterangan
    @Default('Bulanan')
    String paymentScheme, // 'Bulanan', 'Mingguan', 'Tahunan'
    @Default([]) List<String> facilities, // e.g. ['AC', 'Kamar Mandi Dalam']
  }) = _RoomTypeModel;

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeModelFromJson(json);
}
