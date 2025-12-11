import 'package:freezed_annotation/freezed_annotation.dart';

part 'penghuni.freezed.dart';

@freezed
class Penghuni with _$Penghuni {
  const factory Penghuni({
    required String id,
    required String nama,
    required String noHp,
    required String nik,
    String? fotoKtpUrl,
    @Default('Calon') String status,
    DateTime? createdAt,
  }) = _Penghuni;
}
