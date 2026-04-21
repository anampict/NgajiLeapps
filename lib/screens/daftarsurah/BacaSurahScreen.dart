import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/controller/SurahDetailController.dart';

class Bacasurahscreen extends StatelessWidget {
  const Bacasurahscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SurahDetailController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() {
          final detail = controller.surahDetail.value;
          final namaLatin = detail?.namaLatin ?? controller.surah.namaLatin;
          final jumlahAyat = detail?.jumlahAyat ?? controller.surah.jumlahAyat;
          final jenis = detail?.jenis ?? controller.surah.jenis;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                namaLatin,
                style: const TextStyle(
                  fontFamily: 'Primary',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$jumlahAyat AYAT',
                    style: const TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    jenis.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
      body: Obx(() {
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
                  onPressed: controller.fetchDetail,
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

        final detail = controller.surahDetail.value!;
        // Tampilkan header Bismillah untuk semua surah kecuali At-Taubah (9)
        final showBismillah = controller.surah.nomor != 9;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Bismillah Header
              if (showBismillah) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Dengan menyebut nama Allah yang Maha Pemurah lagi Maha Penyayang',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Primary',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Ayat List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: detail.ayat.length,
                itemBuilder: (context, index) {
                  final ayat = detail.ayat[index];
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header nomor + ikon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xff13EC80,
                                    ).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${ayat.nomorAyat}',
                                      style: const TextStyle(
                                        color: Color(0xff13EC80),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.bookmark_border,
                                        color: Color(0xff94A3B8),
                                        size: 20,
                                      ),
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(8),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share_outlined,
                                        color: Color(0xff94A3B8),
                                        size: 20,
                                      ),
                                      constraints: const BoxConstraints(),
                                      padding: const EdgeInsets.all(8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Teks Arab
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                ayat.teksArab,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  height: 2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Terjemahan
                            Text(
                              ayat.teksIndonesia,
                              style: TextStyle(
                                fontFamily: 'Primary',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
