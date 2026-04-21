class Surah {
  final int nomor;
  final String namaLatin;
  final String namaArab;
  final int jumlahAyat;
  final String jenis; // Makkiyah / Madaniyah

  Surah({
    required this.nomor,
    required this.namaLatin,
    required this.namaArab,
    required this.jumlahAyat,
    required this.jenis,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    final tempatTurun = json['tempatTurun'] as String? ?? '';
    final jenis = tempatTurun == 'Mekah' ? 'Makkiyah' : 'Madaniyah';
    return Surah(
      nomor: json['nomor'] as int,
      namaLatin: json['namaLatin'] as String,
      namaArab: json['nama'] as String,
      jumlahAyat: json['jumlahAyat'] as int,
      jenis: jenis,
    );
  }
}

final List<Surah> daftarSurah = [
  Surah(
    nomor: 1,
    namaLatin: 'Al-Fatihah',
    namaArab: 'الفاتحة',
    jumlahAyat: 7,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 2,
    namaLatin: 'Al-Baqarah',
    namaArab: 'البقرة',
    jumlahAyat: 286,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 3,
    namaLatin: "Ali 'Imran",
    namaArab: 'آل عمران',
    jumlahAyat: 200,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 4,
    namaLatin: "An-Nisa'",
    namaArab: 'النساء',
    jumlahAyat: 176,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 5,
    namaLatin: "Al-Ma'idah",
    namaArab: 'المائدة',
    jumlahAyat: 120,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 6,
    namaLatin: "Al-An'am",
    namaArab: 'الأنعام',
    jumlahAyat: 165,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 7,
    namaLatin: 'Al-A\'raf',
    namaArab: 'الأعراف',
    jumlahAyat: 206,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 8,
    namaLatin: 'Al-Anfal',
    namaArab: 'الأنفال',
    jumlahAyat: 75,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 9,
    namaLatin: 'At-Taubah',
    namaArab: 'التوبة',
    jumlahAyat: 129,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 10,
    namaLatin: 'Yunus',
    namaArab: 'يونس',
    jumlahAyat: 109,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 11,
    namaLatin: 'Hud',
    namaArab: 'هود',
    jumlahAyat: 123,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 12,
    namaLatin: 'Yusuf',
    namaArab: 'يوسف',
    jumlahAyat: 111,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 13,
    namaLatin: 'Ar-Ra\'d',
    namaArab: 'الرعد',
    jumlahAyat: 43,
    jenis: 'Madaniyah',
  ),
  Surah(
    nomor: 14,
    namaLatin: 'Ibrahim',
    namaArab: 'إبراهيم',
    jumlahAyat: 52,
    jenis: 'Makkiyah',
  ),
  Surah(
    nomor: 15,
    namaLatin: 'Al-Hijr',
    namaArab: 'الحجر',
    jumlahAyat: 99,
    jenis: 'Makkiyah',
  ),
];
