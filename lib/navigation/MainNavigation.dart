import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/controller/BookmarkController.dart';
import 'package:sm6aplikasiku/controller/JadwalSholatController.dart';
import 'package:sm6aplikasiku/controller/NavigationController.dart';
import 'package:sm6aplikasiku/controller/SurahController.dart';
import 'package:sm6aplikasiku/screens/bookmark/BookmarkScreen.dart';
import 'package:sm6aplikasiku/screens/daftarsurah/DaftarSurahScreen.dart';
import 'package:sm6aplikasiku/screens/dashboard/Homescreen.dart';
import 'package:sm6aplikasiku/screens/jadwalsholat/JadwalSholatScreen.dart';

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final NavigationController navController = Get.put(NavigationController());
  // ignore: unused_field
  final JadwalSholatController _jadwalController = Get.put(
    JadwalSholatController(),
  );
  // ignore: unused_field
  final SurahController _surahController = Get.put(SurahController());
  // ignore: unused_field
  final BookmarkController _bookmarkController = Get.put(BookmarkController());

  final List<Widget> _pages = const [
    Homescreen(),
    Daftarsurahscreen(),
    Jadwalsholatscreen(),
    BookmarkScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _pages[navController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 8,
          currentIndex: navController.selectedIndex.value,
          selectedItemColor: const Color(0xFF1B9B6C),
          unselectedItemColor: const Color(0xFFCCCCCC),
          onTap: (index) => navController.changePage(index),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/menuhome.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  navController.selectedIndex.value == 0
                      ? const Color(0xFF1B9B6C)
                      : const Color(0xFFCCCCCC),
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
                colorFilter: ColorFilter.mode(
                  navController.selectedIndex.value == 1
                      ? const Color(0xFF1B9B6C)
                      : const Color(0xFFCCCCCC),
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
                colorFilter: ColorFilter.mode(
                  navController.selectedIndex.value == 2
                      ? const Color(0xFF1B9B6C)
                      : const Color(0xFFCCCCCC),
                  BlendMode.srcIn,
                ),
              ),
              label: 'Sholat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                navController.selectedIndex.value == 3
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_outline_rounded,
                size: 26,
                color: navController.selectedIndex.value == 3
                    ? const Color(0xFF1B9B6C)
                    : const Color(0xFFCCCCCC),
              ),
              label: 'Bookmark',
            ),
          ],
        ),
      ),
    );
  }
}
