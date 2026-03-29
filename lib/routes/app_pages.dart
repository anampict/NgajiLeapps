import 'package:get/get.dart';
import 'package:sm6aplikasiku/navigation/MainNavigation.dart';
import 'package:sm6aplikasiku/routes/app_routes.dart';
import 'package:sm6aplikasiku/screens/SplashScreen.dart';
import 'package:sm6aplikasiku/screens/daftarsurah/BacaSurahScreen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => const Splashscreen()),
    GetPage(name: AppRoutes.main, page: () => MainNavigation()),
    GetPage(name: AppRoutes.bacaSurah, page: () => const Bacasurahscreen()),
  ];
}
