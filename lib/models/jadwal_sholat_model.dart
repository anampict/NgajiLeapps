class JadwalSholatHarian {
  final int tanggal;
  final String tanggalLengkap;
  final String hari;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  JadwalSholatHarian({
    required this.tanggal,
    required this.tanggalLengkap,
    required this.hari,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  factory JadwalSholatHarian.fromJson(Map<String, dynamic> json) {
    return JadwalSholatHarian(
      tanggal: json['tanggal'] as int,
      tanggalLengkap: json['tanggal_lengkap'] as String,
      hari: json['hari'] as String,
      imsak: json['imsak'] as String,
      subuh: json['subuh'] as String,
      terbit: json['terbit'] as String,
      dhuha: json['dhuha'] as String,
      dzuhur: json['dzuhur'] as String,
      ashar: json['ashar'] as String,
      maghrib: json['maghrib'] as String,
      isya: json['isya'] as String,
    );
  }
}

class JadwalSholatBulanan {
  final String provinsi;
  final String kabkota;
  final int bulan;
  final int tahun;
  final String bulanNama;
  final List<JadwalSholatHarian> jadwal;

  JadwalSholatBulanan({
    required this.provinsi,
    required this.kabkota,
    required this.bulan,
    required this.tahun,
    required this.bulanNama,
    required this.jadwal,
  });

  factory JadwalSholatBulanan.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return JadwalSholatBulanan(
      provinsi: data['provinsi'] as String,
      kabkota: data['kabkota'] as String,
      bulan: data['bulan'] as int,
      tahun: data['tahun'] as int,
      bulanNama: data['bulan_nama'] as String,
      jadwal: (data['jadwal'] as List<dynamic>)
          .map((e) => JadwalSholatHarian.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
