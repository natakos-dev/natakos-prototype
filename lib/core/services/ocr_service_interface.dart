class KtpData {
  final String? nama;
  final String? nik;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? alamat;

  KtpData({
    this.nama,
    this.nik,
    this.tempatLahir,
    this.tanggalLahir,
    this.alamat,
  });
}

abstract class OcrService {
  Future<KtpData?> extractData(String imagePath);
}
