import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/routes/app_pages.dart';
import 'package:sm6aplikasiku/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NgajiLe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B9B6C)),
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.pages,
    );
  }
}
