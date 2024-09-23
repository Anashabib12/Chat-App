import 'dart:async';
import 'package:chat_app/views/intro_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const IntroScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFEEDA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;

          return Stack(
            children: [
              Center(
                child: Image.asset('assets/logo/logo.png'),
              ),
              Positioned(
                bottom: -height * 0.04,
                left: -width * 0.095,
                child: Image.asset(
                  'assets/images/f1.png',
                  height: height * 0.3, // Adjust the size proportionally
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
