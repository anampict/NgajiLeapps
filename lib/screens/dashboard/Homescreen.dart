import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sm6aplikasiku/controller/JadwalSholatController.dart';
import 'package:sm6aplikasiku/controller/NavigationController.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();
    final jadwalController = Get.find<JadwalSholatController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            const Text(
              'NgajiLe',
              style: TextStyle(
                fontFamily: 'Primary',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B9B6C),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Assalamualaikum, Ahmad',
                style: TextStyle(
                  fontFamily: 'Primary',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/icontanggal.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF059669),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),

                  Text(
                    DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now()),
                    style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF059669),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // card waktu sholat
              Obx(() {
                final isLoading = jadwalController.isLoading.value;
                final nama = jadwalController.namaBerikutnya.value;
                final waktu = jadwalController.waktuBerikutnya.value;
                final selisih = jadwalController.selisihBerikutnya.value;

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1B9B6C), Color(0xFF157556)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/iconlokasi.svg',
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'KAB. PASURUAN, ID',
                            style: TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Waktu Sholat Berikutnya',
                        style: TextStyle(
                          fontFamily: 'Primary',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (isLoading)
                        const CircularProgressIndicator(color: Colors.white)
                      else ...[
                        Text(
                          nama.isEmpty ? '-' : '$nama - $waktu WIB',
                          style: const TextStyle(
                            fontFamily: 'Primary',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          selisih,
                          style: TextStyle(
                            fontFamily: 'Primary',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => navController.changePage(2),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF1B9B6C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/jadwalsholat.svg',
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF059669),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Lihat Jadwal Lengkap',
                                style: TextStyle(
                                  fontFamily: 'Primary',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1B9B6C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              // Menu Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuIcon(
                    'assets/icons/menubacaquran.svg',
                    'Al-Quran',
                    onTap: () => navController.changePage(1),
                  ),
                  _buildMenuIcon(
                    'assets/icons/menujadwalsholat.svg',
                    'Jadwal',
                    onTap: () => navController.changePage(2),
                  ),
                  _buildMenuIcon(
                    'assets/icons/menubookmark.svg',
                    'Bookmark',
                    onTap: () => navController.changePage(3),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '""',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1CC95F),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '"Banyaklah membaca Al Quran, karena ia akan menjadi teman setiamu di surga."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '- Abdullah bin Umar',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuIcon(
    String iconPath,
    String label, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 35,
                height: 35,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF1B9B6C),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Primary',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

}

