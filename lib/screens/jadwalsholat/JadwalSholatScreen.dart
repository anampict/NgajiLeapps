import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/controller/JadwalSholatController.dart';

class Jadwalsholatscreen extends StatelessWidget {
  const Jadwalsholatscreen({super.key});

  String _iconAsset(String nama) {
    switch (nama.toLowerCase()) {
      case 'imsak':
        return 'assets/icons/iconimsak.svg';
      case 'subuh':
      case 'isya':
        return 'assets/icons/iconsubuh.svg';
      case 'dzuhur':
      case 'ashar':
        return 'assets/icons/icondzuhur.svg';
      case 'maghrib':
        return 'assets/icons/iconimsak.svg';
      default:
        return 'assets/icons/iconsubuh.svg';
    }
  }

  String _formatTanggal(DateTime dt) {
    const hariList = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    const bulanList = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final hari = hariList[dt.weekday % 7];
    final bulan = bulanList[dt.month];
    return '$hari, ${dt.day} $bulan ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JadwalSholatController>();
    final now = DateTime.now();
    final tanggalFormatted = _formatTanggal(now);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Jadwal Sholat',
          style: TextStyle(
            fontFamily: 'Primary',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xff16A34A)),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                const SizedBox(height: 12),
                Text(
                  'Gagal memuat data',
                  style: TextStyle(
                    fontFamily: 'Primary',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () =>
                      controller.fetchJadwal(tahun: now.year, bulan: now.month),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff16A34A),
                  ),
                  child: const Text(
                    'Coba Lagi',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        final daftar = controller.daftarWaktuHariIni;
        final namaBerikutnya = controller.namaBerikutnya.value;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Lokasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/iconlokasi.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xff16A34A),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'LOKASI: KAB. PASURUAN, JAWA TIMUR',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff16A34A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    tanggalFormatted,
                    style: const TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff64748B),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Card Waktu Berikutnya
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff16A34A),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WAKTU BERIKUTNYA',
                            style: TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            namaBerikutnya,
                            style: const TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${controller.waktuBerikutnya.value} WIB',
                            style: const TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.selisihBerikutnya.value,
                            style: TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            _iconAsset(namaBerikutnya),
                            width: 40,
                            height: 40,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                const Text(
                  'Waktu Sholat',
                  style: TextStyle(
                    fontFamily: 'Primary',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final entry = daftar[index];
                    final isActive = entry.key == namaBerikutnya;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xffE0F2F1)
                              : const Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(12),
                          border: isActive
                              ? Border.all(
                                  color: const Color(0xff16A34A),
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xff16A34A)
                                    : const Color(0xffE8E8E8),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  _iconAsset(entry.key),
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    isActive ? Colors.white : Colors.black54,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontFamily: 'Primary',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isActive
                                          ? const Color(0xff16A34A)
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontFamily: 'Primary',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: isActive
                                          ? const Color(0xff16A34A)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
