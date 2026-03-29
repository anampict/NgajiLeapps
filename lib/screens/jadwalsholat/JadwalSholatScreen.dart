import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WaktuSholat {
  final String nama;
  final String waktu;
  final String tipe; // imsak, subuh, dzuhur, subuh, isya
  final bool isSedangBerlangsung;

  WaktuSholat({
    required this.nama,
    required this.waktu,
    required this.tipe,
    this.isSedangBerlangsung = false,
  });
}

class Jadwalsholatscreen extends StatelessWidget {
  const Jadwalsholatscreen({super.key});

  // Fungsi untuk mendapatkan icon berdasarkan tipe
  String getIconAsset(String tipe) {
    switch (tipe) {
      case 'imsak':
        return 'assets/icons/iconimsak.svg';
      case 'subuh':
      case 'isya':
        return 'assets/icons/iconsubuh.svg';
      case 'dzuhur':
      case 'asar':
        return 'assets/icons/icondzuhur.svg';
      case 'maghrib':
        return 'assets/icons/iconimsak.svg';
      default:
        return 'assets/icons/iconsubuh.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<WaktuSholat> jadwalSholat = [
      WaktuSholat(nama: 'Imsak', waktu: '04:15 WIB', tipe: 'imsak'),
      WaktuSholat(
        nama: 'Subuh',
        waktu: '04:25 WIB',
        tipe: 'subuh',
        isSedangBerlangsung: true,
      ),
      WaktuSholat(nama: 'Dzuhur', waktu: '11:42 WIB', tipe: 'dzuhur'),
      WaktuSholat(nama: 'Ashar', waktu: '14:54 WIB', tipe: 'asar'),
      WaktuSholat(nama: 'Maghrib', waktu: '17:51 WIB', tipe: 'maghrib'),
      WaktuSholat(nama: 'Isya', waktu: '19:15 WIB', tipe: 'isya'),
    ];

    final sedangBerlangsung = jadwalSholat.firstWhere(
      (s) => s.isSedangBerlangsung,
    );

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Lokasi dan Tanggal
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
                  Text(
                    'LOKASI: PASURUAN, INDONESIA',
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
                  "Kamis, 24 Okt 2024 • 21 Rabi'ul Akhir 1446 H",
                  style: TextStyle(
                    fontFamily: 'Primary',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff64748B),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Card Sedang Berlangsung
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
                          'SEDANG BERLANGSUNG',
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
                          sedangBerlangsung.nama,
                          style: const TextStyle(
                            fontFamily: 'Primary',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sedangBerlangsung.waktu,
                          style: const TextStyle(
                            fontFamily: 'Primary',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
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
                          getIconAsset(sedangBerlangsung.tipe),
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

              // Title Waktu Sholat
              Text(
                'Waktu Sholat',
                style: TextStyle(
                  fontFamily: 'Primary',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // List Jadwal Sholat
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jadwalSholat.length,
                itemBuilder: (context, index) {
                  final sholat = jadwalSholat[index];
                  final isActive = sholat.isSedangBerlangsung;

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
                          // Icon
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
                                getIconAsset(sholat.tipe),
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
                          // Nama dan Waktu
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sholat.nama,
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
                                  sholat.waktu,
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
      ),
    );
  }
}
