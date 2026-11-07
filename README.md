# TravelBuddy 🌍

Aplikasi mobile untuk mencari informasi negara dan menyimpan destinasi wisata favorit. TravelBuddy dikembangkan menggunakan Flutter sebagai proyek Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile.

## Deskripsi Aplikasi

TravelBuddy membantu pengguna menjelajahi berbagai negara melalui informasi destinasi yang diperoleh dari REST API. Pengguna juga dapat menyimpan destinasi favorit ke dalam Wishlist sehingga dapat melihat, menambahkan, mengubah, dan menghapus daftar destinasi yang disimpan.

## Fitur Utama

1. **Home** – Menampilkan rekomendasi negara dari REST API.
2. **Detail Destinasi** – Menampilkan informasi negara yang dipilih.
3. **Wishlist** – Menampilkan destinasi favorit pengguna.
4. **Tambah Wishlist** – Menambahkan destinasi ke daftar favorit.
5. **Edit Wishlist** – Mengubah informasi wishlist.
6. **Hapus Wishlist** – Menghapus destinasi dari wishlist.
7. **Profil** – Menampilkan informasi aplikasi.
8. **Responsive Layout** – Mendukung tampilan compact dan wide.
9. **Loading dan Error State** – Memberikan informasi ketika data sedang dimuat atau terjadi kesalahan.

## Teknologi yang Digunakan

- Flutter
- Dart
- Provider
- REST API
- HTTP
- Supabase
- PostgreSQL
- Git dan GitHub

## Sumber Data

### REST API

Aplikasi menggunakan API dari:

https://countries.dev

API digunakan untuk mengambil informasi negara, seperti nama negara, wilayah, ibu kota, bendera, peta, dan jumlah penduduk.

### Database Supabase

Supabase digunakan untuk menyimpan data Wishlist.

Nama tabel: `wishlists`

Kolom tabel:

| Kolom | Tipe Data |
|---|---|
| id | UUID |
| destination_id | TEXT |
| destination_name | TEXT |
| notes | TEXT |
| created_at | TIMESTAMPTZ |

Operasi database yang digunakan meliputi:
- Create
- Read
- Update
- Delete

## Struktur Folder

```text
lib/
├── config/
│   └── supabase_config.dart
├── models/
│   ├── destination_model.dart
│   └── wishlist_model.dart
├── providers/
│   ├── destination_provider.dart
│   └── wishlist_provider.dart
├── repositories/
│   ├── destination_repository.dart
│   └── wishlist_repository.dart
├── screens/
│   ├── add_wishlist_screen.dart
│   ├── detail_screen.dart
│   ├── edit_wishlist_screen.dart
│   ├── home_screen.dart
│   ├── navigation_screen.dart
│   └── wishlist_screen.dart
├── services/
│   ├── destination_api_service.dart
│   └── wishlist_supabase_service.dart
└── main.dart
```

## Cara Menjalankan Aplikasi

1. Clone repository:

```bash
git clone https://github.com/ellapsrb/travel-buddy.git
```

2. Masuk ke folder proyek:

```bash
cd travel-buddy
```

3. Install dependencies:

```bash
flutter pub get
```

4. Konfigurasikan URL dan Publishable Key Supabase pada:

```text
lib/config/supabase_config.dart
```

Gunakan konfigurasi proyek Supabase milik sendiri. Jangan membagikan secret key atau service role key.

5. Jalankan aplikasi:

```bash
flutter run
```

## Responsive Design

TravelBuddy memiliki dua kondisi tampilan:

- **Compact:** navigasi berada di bagian bawah layar dan daftar destinasi ditampilkan dalam satu kolom.
- **Wide:** navigasi berada di samping layar dan daftar destinasi ditampilkan dalam dua kolom.

## Repository GitHub

https://github.com/ellapsrb/travel-buddy

## Pengembang

Proyek ini dibuat sebagai tugas Ujian Tengah Semester mata kuliah Pemrograman Mobile.