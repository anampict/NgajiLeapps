import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/controller/SurahController.dart';
import 'package:sm6aplikasiku/routes/app_routes.dart';

class Daftarsurahscreen extends StatelessWidget {
  const Daftarsurahscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SurahController>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Daftar Surah',
          style: TextStyle(
            fontFamily: 'Primary',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Cari Surah...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1B9B6C)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF1B9B6C)),
                ),
              ),
            ),
          ),
          // List of Surah
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1B9B6C)),
                );
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text(
                        'Gagal memuat data',
                        style: TextStyle(
                          fontFamily: 'Primary',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: controller.fetchSurah,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B9B6C),
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

              final list = controller.filteredSurah;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final surah = list[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () =>
                          Get.toNamed(AppRoutes.bacaSurah, arguments: surah),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Nomor dengan Icon BorderAyat
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/borderayat.svg',
                                    width: 50,
                                    height: 50,
                                  ),
                                  Text(
                                    surah.nomor.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Primary',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1B9B6C),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              // Informasi Surah
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      surah.namaLatin,
                                      style: const TextStyle(
                                        fontFamily: 'Primary',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${surah.jumlahAyat} AYAT • ${surah.jenis.toUpperCase()}',
                                      style: const TextStyle(
                                        fontFamily: 'Primary',
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Nama Arab
                              Text(
                                surah.namaArab,
                                style: const TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B9B6C),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
