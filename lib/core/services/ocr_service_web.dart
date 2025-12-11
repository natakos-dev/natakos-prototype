import 'ocr_service_interface.dart';

class OcrServiceWeb implements OcrService {
  @override
  Future<KtpData?> extractData(String imagePath) async {
    // Simulasi delay
    await Future.delayed(const Duration(seconds: 2));

    // Data Mock untuk Web
    return KtpData(
      nama: 'Ahmad Dahlan',
      nik: '3171234567890001',
      tempatLahir: 'Jakarta',
      tanggalLahir: '17-08-1990',
      alamat: 'Jl. Proklamasi No. 56, Menteng, Jakarta Pusat',
    );
  }
}

OcrService getOcrService() => OcrServiceWeb();
