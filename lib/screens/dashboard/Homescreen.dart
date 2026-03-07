import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    '15 Ramadan 1445 H',
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                          'PASURUAN, ID',
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
                    Text(
                      'Ashar - 15:24',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '1 jam 12 menit lagi',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF1B9B6C),
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
              ),
              const SizedBox(height: 24),
              // Menu Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuIcon('assets/icons/menubacaquran.svg', 'Al-Quran'),
                  _buildMenuIcon('assets/icons/menujadwalsholat.svg', 'Jadwal'),
                  _buildMenuIcon('assets/icons/menucatatan.svg', 'Catatan'),
                ],
              ),
              const SizedBox(height: 24),
              // Last Read Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terakhir Dibaca',
                    style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Lainnya',
                    style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1B9B6C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF1B9B6C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.library_books,
                      color: Color(0xFF1B9B6C),
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Al-Kahf',
                            style: TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Ayat 1 - 10',
                            style: TextStyle(
                              fontFamily: 'Primary',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.play_circle_filled,
                      color: Color(0xFF1B9B6C),
                      size: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // progres harian bar
              Text(
                'Progres Harian',
                style: TextStyle(
                  fontFamily: 'Primary',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.75,
                            minHeight: 8,
                            backgroundColor: Color(0xFFE0E0E0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF1B9B6C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '75%',
                    style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B9B6C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildProgressItem('SHOLAT', '4/5'),
                  _buildProgressItem('QURAN', '2 Juz'),
                  _buildProgressItem('DZIKIR', '300x'),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: Color(0xFF1B9B6C),
        unselectedItemColor: Color(0xFFCCCCCC),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/menuhome.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Color(0xFF1B9B6C),
                BlendMode.srcIn,
              ),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/menuquran.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Color(0xFFCCCCCC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/menusholat.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Color(0xFFCCCCCC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Sholat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/menuprofil.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Color(0xFFCCCCCC),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcon(String iconPath, String label) {
    return Column(
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
    );
  }

  Widget _buildProgressItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Primary',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF999999),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Primary',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
