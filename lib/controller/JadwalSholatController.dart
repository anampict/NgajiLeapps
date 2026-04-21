import 'package:get/get.dart';
import 'package:sm6aplikasiku/models/jadwal_sholat_model.dart';
import 'package:sm6aplikasiku/services/jadwal_sholat_service.dart';

class JadwalSholatController extends GetxController {
  final JadwalSholatService _service = JadwalSholatService();

  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final jadwalBulanan = Rxn<JadwalSholatBulanan>();

  // Jadwal hari ini
  final jadwalHariIni = Rxn<JadwalSholatHarian>();

  // Waktu sholat berikutnya
  final namaBerikutnya = ''.obs;
  final waktuBerikutnya = ''.obs;
  final selisihBerikutnya = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    fetchJadwal(tahun: now.year, bulan: now.month);
  }

  Future<void> fetchJadwal({required int tahun, required int bulan}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final data = await _service.fetchJadwal(tahun: tahun, bulan: bulan);
      jadwalBulanan.value = data;
      _setJadwalHariIni();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _setJadwalHariIni() {
    final today = DateTime.now().day;
    final jadwal = jadwalBulanan.value?.jadwal;
    if (jadwal == null) return;

    try {
      jadwalHariIni.value = jadwal.firstWhere((j) => j.tanggal == today);
    } catch (_) {
      jadwalHariIni.value = null;
    }
    _hitungWaktuBerikutnya();
  }

  void _hitungWaktuBerikutnya() {
    final hariIni = jadwalHariIni.value;
    if (hariIni == null) return;

    final now = DateTime.now();

    final List<MapEntry<String, String>> waktuList = [
      MapEntry('Imsak', hariIni.imsak),
      MapEntry('Subuh', hariIni.subuh),
      MapEntry('Dzuhur', hariIni.dzuhur),
      MapEntry('Ashar', hariIni.ashar),
      MapEntry('Maghrib', hariIni.maghrib),
      MapEntry('Isya', hariIni.isya),
    ];

    for (final entry in waktuList) {
      final parts = entry.value.split(':');
      if (parts.length != 2) continue;
      final jam = int.tryParse(parts[0]);
      final menit = int.tryParse(parts[1]);
      if (jam == null || menit == null) continue;

      final waktuDt = DateTime(now.year, now.month, now.day, jam, menit);
      if (waktuDt.isAfter(now)) {
        namaBerikutnya.value = entry.key;
        waktuBerikutnya.value = entry.value;
        final diff = waktuDt.difference(now);
        selisihBerikutnya.value = _formatSelisih(diff);
        return;
      }
    }

    // Jika semua sudah lewat, tampilkan Subuh besok
    namaBerikutnya.value = 'Subuh';
    waktuBerikutnya.value = hariIni.subuh;
    selisihBerikutnya.value = 'Besok';
  }

  String _formatSelisih(Duration diff) {
    final jam = diff.inHours;
    final menit = diff.inMinutes % 60;
    if (jam > 0) {
      return '$jam jam $menit menit lagi';
    }
    return '$menit menit lagi';
  }

  /// Kembalikan list waktu sholat untuk tampil di screen (imsak + 5 waktu)
  List<MapEntry<String, String>> get daftarWaktuHariIni {
    final hariIni = jadwalHariIni.value;
    if (hariIni == null) return [];
    return [
      MapEntry('Imsak', '${hariIni.imsak} WIB'),
      MapEntry('Subuh', '${hariIni.subuh} WIB'),
      MapEntry('Dzuhur', '${hariIni.dzuhur} WIB'),
      MapEntry('Ashar', '${hariIni.ashar} WIB'),
      MapEntry('Maghrib', '${hariIni.maghrib} WIB'),
      MapEntry('Isya', '${hariIni.isya} WIB'),
    ];
  }
}
