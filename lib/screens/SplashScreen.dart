import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/routes/app_routes.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(child: Image.asset('assets/images/logoapk.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Text(
              "Teman Ibadah Harian Anda",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff64748B),
                fontFamily: "Primary",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
