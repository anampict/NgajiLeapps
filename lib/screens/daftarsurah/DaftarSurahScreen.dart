import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/surah.dart';

class Daftarsurahscreen extends StatefulWidget {
  const Daftarsurahscreen({super.key});

  @override
  State<Daftarsurahscreen> createState() => _DaftarsurahscreenState();
}

class _DaftarsurahscreenState extends State<Daftarsurahscreen> {
  late List<Surah> filteredSurah;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredSurah = daftarSurah;
  }

  void searchSurah(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredSurah = daftarSurah;
      } else {
        filteredSurah = daftarSurah
            .where(
              (surah) =>
                  surah.namaLatin.toLowerCase().contains(value.toLowerCase()) ||
                  surah.nomor.toString().contains(value),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1B9B6C).withOpacity(0.2),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFF1B9B6C),
                iconSize: 25,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Daftar Surah',
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: searchSurah,
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredSurah.length,
              itemBuilder: (context, index) {
                final surah = filteredSurah[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
