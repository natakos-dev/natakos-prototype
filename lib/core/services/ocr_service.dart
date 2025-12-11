import 'ocr_service_interface.dart';
import 'ocr_service_web.dart' if (dart.library.io) 'ocr_service_mobile.dart';

export 'ocr_service_interface.dart';

class OcrServiceFactory {
  static OcrService create() {
    return getOcrService();
  }
}
