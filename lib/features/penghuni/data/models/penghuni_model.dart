import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/penghuni.dart';

class PenghuniModel {
  static Penghuni fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Penghuni(
      id: doc.id,
      nama: data['nama'] ?? '',
      noHp: data['noHp'] ?? '',
      nik: data['nik'] ?? '',
      fotoKtpUrl: data['fotoKtpUrl'],
      status: data['status'] ?? 'Calon',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  static Map<String, dynamic> toFirestore(Penghuni penghuni) {
    return {
      'nama': penghuni.nama,
      'noHp': penghuni.noHp,
      'nik': penghuni.nik,
      'fotoKtpUrl': penghuni.fotoKtpUrl,
      'status': penghuni.status,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
