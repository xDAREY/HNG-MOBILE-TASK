import 'package:country_info/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;

  const SplashScreen({super.key, required this.onThemeToggle});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(onThemeToggle: widget.onThemeToggle),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/country_info_splash.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
