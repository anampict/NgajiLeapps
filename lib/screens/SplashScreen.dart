import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

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
