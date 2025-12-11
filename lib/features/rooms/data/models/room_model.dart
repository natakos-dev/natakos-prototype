import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String id, // Firestore ID
    required String roomNumber, // kodeKamar
    required int floor, // lantai
    @Default(true) bool isActive, // aktif
    required String roomTypeId, // tipeKamarId (Reference)

    // Flattened/Joined fields for UI convenience (optional, or handle in repository)
    String? currentTenantName,
    @Default('Kosong') String status, // 'Terisi', 'Kosong'
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
