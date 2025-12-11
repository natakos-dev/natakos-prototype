# 🏠 Natakos - Manajemen Kos Anti Ribet

Selamat datang di **Natakos**! Aplikasi manajemen rumah kos jaman now yang bikin hidup juragan kos makin santuy. Gak perlu lagi tuh buku catetan kucel atau pusing ngitung tagihan manual. Semua ada di genggaman! 🚀

---

## ✨ Fitur-Fitur Kece

Aplikasi ini gak cuma modal tampang doang, tapi isinya "daging" semua:

*   📱 **Multi-Platform**: Jalan mulus di Android (dan soon di iOS & Web).
*   🤖 **OCR KTP Pintar**: Males ngetik data penghuni? Foto aja KTP-nya, biar AI (Google ML Kit) yang ngerjain sisanya.
*   💾 **Offline-First**: Internet mati? Tenang, data aman tersimpan lokal pake **Isar DB**. Begitu online, langsung sinkron!
*   🔥 **Powered by Firebase**: Auth aman user, data tersimpan di Cloud Firestore, dan aset aman di Storage.
*   ⚡ **State Management Modern**: Dibangun pake **Riverpod**, performa ngebut, kode rapi, minim bug.

## 🛠️ Tech Stack (Senjata Kita)

Kita pake teknologi paling hits di dunia Flutter:
*   **Framework**: Flutter SDK 3.x
*   **State Management**: Riverpod (Hooks & Annotation)
*   **Database**: Isar (Lokal) & Firestore (Cloud)
*   **Navigasi**: GoRouter
*   **Utilities**: FPdart, Freezed, Json Serializable

---

## 🚀 Cara Mulai (Gaspol!)

Ikuti langkah-langkah simpel ini biar Natakos bisa jalan di laptop kamu:

### 1. Persiapan
Pastikan kamu udah install **Flutter SDK** terbaru. Belum punya? [Cek di sini dulu](https://docs.flutter.dev/get-started/install).

### 2. Clone Project
Download source code-nya ke kandang (folder) kamu:
```bash
git clone https://github.com/natakos-dev/natakos-prototype.git
cd natakos-prototype
```

### 3. Install Paket
Panggil semua pasukan library yang kita butuhin:
```bash
flutter pub get
```

### 4. 🔑 Konfigurasi Rahasia (Wajib!)
Aplikasi ini butuh "kunci" beneran buat nyambung ke Firebase. 
Buat file baru bernama `.env` di folder paling luar (root directory), terus isi ginian:

```env
FIREBASE_API_KEY_WEB=isi_punya_kamu_disini
FIREBASE_APP_ID_WEB=isi_punya_kamu_disini
FIREBASE_AUTH_DOMAIN_WEB=isi_punya_kamu_disini
FIREBASE_API_KEY_ANDROID=isi_punya_kamu_disini
FIREBASE_APP_ID_ANDROID=isi_punya_kamu_disini
FIREBASE_MESSAGING_SENDER_ID=isi_punya_kamu_disini
FIREBASE_PROJECT_ID=isi_punya_kamu_disini
FIREBASE_STORAGE_BUCKET=isi_punya_kamu_disini
```

> **Bingung dapetnya di mana?** Buka [Firebase Console](https://console.firebase.google.com/), masuk ke Project Settings, dan copas config-nya dari sana.

### 5. Generate Code
Karena kita pake `build_runner` buat generate kode-kode magis (Riverpod, Isar, Freezed), jalanin ini dulu:
```bash
dart run build_runner build --delete-conflicting-outputs
```
*(Atau pake `watch` kalau lagi mode ngoding)*

### 6. Jalankan Aplikasi
Tancap gas! 🏁
```bash
flutter run
```

---

## 🤝 Mau Ikut Berkontribusi?

Ada ide fitur atau nemu bug? Langsung aja buka issue baru atau kalau mau support ngopi kita, nanti kami sediakan link Saweria ngohehehe! 😉

---

*Dibuat dengan ☕ dan ❤️ oleh Tim Natakos.*
