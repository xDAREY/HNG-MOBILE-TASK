import 'package:country_info/screens/homescreen.dart';
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
    _navigateToHome();
  }

  void _navigateToHome() async {
  await Future.delayed(const Duration(seconds: 5));

  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          onThemeToggle: widget.onThemeToggle,
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(
          'assets/images/country_info_splash.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}