import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'ocr_service_interface.dart';

class OcrServiceMobile implements OcrService {
  @override
  Future<KtpData?> extractData(String imagePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      return _parseKtpText(recognizedText.text);
    } catch (e) {
      print('OCR Error: $e');
      return null;
    } finally {
      await textRecognizer.close();
    }
  }

  KtpData _parseKtpText(String text) {
    String? nama;
    String? nik;
    String? tempatLahir;
    String? tanggalLahir;
    String? alamat;

    final lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      String upperLine = line.toUpperCase();

      // NIK Detection: 16 digits
      // Sometimes OCR reads 'NIK' as 'NIK :', 'NIK', etc.
      // We look for a sequence of 16 digits.
      if (nik == null) {
        // Remove common OCR noise for NIK
        String cleanLine = line.replaceAll(RegExp(r'[^0-9]'), '');
        if (cleanLine.length == 16) {
          nik = cleanLine;
        } else if (cleanLine.length > 16) {
          // Maybe contain garbage at start/end
          // simple sliding window or regex
          final nikRegex = RegExp(r'\d{16}');
          final match = nikRegex.firstMatch(cleanLine);
          if (match != null) {
            nik = match.group(0);
          }
        }
      }

      // Nama Detection
      // Look for "Nama" keyword
      if (nama == null && (upperLine.contains('NAMA'))) {
        // Case 1: "Nama : Budi Santoso"
        if (line.contains(':')) {
          final parts = line.split(':');
          if (parts.length > 1) {
            String potentialName = parts[1].trim();
            // Clean non-alpha characters if needed, but names can have '.', ',', tokens
            if (potentialName.isNotEmpty && potentialName.length > 2) {
              // Filter out if it looks like garbage
              if (!potentialName.contains(RegExp(r'[0-9]'))) {
                nama = potentialName;
              }
            }
          }
        }

        // Case 2: "Nama" on one line, Name on next line
        if (nama == null && i + 1 < lines.length) {
          String nextLine = lines[i + 1].trim();
          // Heuristics: All caps is common in KTP, reasonable length, no numbers
          // Avoid "Tempat/Tgl Lahir" if that comes next
          if (nextLine.length > 2 &&
              !nextLine.toUpperCase().contains('LAHIR') &&
              !nextLine.contains(RegExp(r'[0-9]'))) {
            nama = nextLine;
          }
        }
      }

      // TTL Detection "Tempat/Tgl Lahir"
      if ((tempatLahir == null || tanggalLahir == null) &&
          upperLine.contains('LAHIR')) {
        // Pattern: JAKARTA, 17-08-1945 or 17-08-1945
        // Find date first
        final dateRegex = RegExp(r'\d{2}-\d{2}-\d{4}');
        final dateMatch = dateRegex.firstMatch(line);

        if (dateMatch != null) {
          tanggalLahir = dateMatch.group(0);

          // Place is typically before the date
          int dateIndex = line.indexOf(tanggalLahir!);
          if (dateIndex > 0) {
            String beforeDate = line.substring(0, dateIndex);
            // Cleanup "Tempat/Tgl Lahir", ":", ","
            String cleanPlace = beforeDate
                .replaceAll(
                    RegExp(r'(TEMPAT|Tempat|TGL|Tgl|LAHIR|Lahir|:|/|,)'), '')
                .trim();

            if (cleanPlace.isNotEmpty && cleanPlace.length > 2) {
              tempatLahir = cleanPlace;
            }
          }
        } else {
          // Case where Date might be on next line (rare for KTP but possible) or OCR failure
          // Trying next line for date if current line has "Lahir"
          if (i + 1 < lines.length) {
            final nextLine = lines[i + 1];
            final nextDateMatch = dateRegex.firstMatch(nextLine);
            if (nextDateMatch != null) {
              tanggalLahir = nextDateMatch.group(0);
            }
          }
        }
      }

      // Alamat Detection
      if (alamat == null && upperLine.contains('ALAMAT')) {
        if (line.contains(':')) {
          final parts = line.split(':');
          if (parts.length > 1 && parts[1].trim().isNotEmpty) {
            alamat = parts[1].trim();
          }
        }
        // Address often spills to next line
        if (alamat == null && i + 1 < lines.length) {
          String nextLine = lines[i + 1].trim();
          // Verify it's not the next field like "RT/RW"
          if (!nextLine.toUpperCase().contains('RT/RW') &&
              !nextLine.toUpperCase().contains('KEL') &&
              !nextLine.toUpperCase().contains('KEC')) {
            alamat = nextLine;
          }
        }
      }
    }

    // Fallback/Cleanup
    if (nama != null) {
      nama = nama.replaceAll(RegExp(r"[^a-zA-Z\s\.,']"), '').trim();
    }

    return KtpData(
      nama: nama,
      nik: nik,
      tempatLahir: tempatLahir,
      tanggalLahir: tanggalLahir,
      alamat: alamat,
    );
  }
}

OcrService getOcrService() => OcrServiceMobile();
