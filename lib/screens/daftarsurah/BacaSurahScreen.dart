import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ayat {
  final int nomor;
  final String teksArab;
  final String terjemahan;

  Ayat({required this.nomor, required this.teksArab, required this.terjemahan});
}

class Bacasurahscreen extends StatefulWidget {
  const Bacasurahscreen({super.key});

  @override
  State<Bacasurahscreen> createState() => _BacasurahscreenState();
}

class _BacasurahscreenState extends State<Bacasurahscreen> {
  final List<Ayat> ayatList = [
    Ayat(
      nomor: 1,
      teksArab: 'الحمد لله رب العالمين',
      terjemahan: 'Segala puji bagi Allah, Tuhan semesta alam,',
    ),
    Ayat(
      nomor: 2,
      teksArab: 'الرحمن الرحيم',
      terjemahan: 'Yang Maha Pemurah lagi Maha Penyayang.',
    ),
    Ayat(
      nomor: 3,
      teksArab: 'مالك يوم الدين',
      terjemahan: '(Dialah) Penguasa hari Pembalasan.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 90),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Al-Baqarah',
                  style: TextStyle(
                    fontFamily: 'Primary',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '286 AYAT',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'MADANIYAH',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Bismillah Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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

            // Ayat List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ayatList.length,
              itemBuilder: (context, index) {
                final ayat = ayatList[index];
                return Column(
                  children: [
                    // Card Ayat
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header dengan nomor dan icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Nomor Ayat
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
                                    '${ayat.nomor}',
                                    style: const TextStyle(
                                      color: Color(0xff13EC80),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              // Icons
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
                            ayat.terjemahan,
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
      ),
    );
  }
}
