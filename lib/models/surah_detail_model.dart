class AyatDetail {
  final int nomorAyat;
  final String teksArab;
  final String teksIndonesia;

  AyatDetail({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksIndonesia,
  });

  factory AyatDetail.fromJson(Map<String, dynamic> json) {
    return AyatDetail(
      nomorAyat: json['nomorAyat'] as int,
      teksArab: json['teksArab'] as String,
      teksIndonesia: json['teksIndonesia'] as String,
    );
  }
}

class SurahDetail {
  final String namaLatin;
  final String namaArab;
  final int jumlahAyat;
  final String tempatTurun;
  final List<AyatDetail> ayat;

  SurahDetail({
    required this.namaLatin,
    required this.namaArab,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.ayat,
  });

  String get jenis => tempatTurun == 'Mekah' ? 'Makkiyah' : 'Madaniyah';

  factory SurahDetail.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return SurahDetail(
      namaLatin: data['namaLatin'] as String,
      namaArab: data['nama'] as String,
      jumlahAyat: data['jumlahAyat'] as int,
      tempatTurun: data['tempatTurun'] as String,
      ayat: (data['ayat'] as List<dynamic>)
          .map((e) => AyatDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
