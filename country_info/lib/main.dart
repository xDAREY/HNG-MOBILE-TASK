import 'package:flutter/material.dart';
import 'package:country_info/screens/splash_screen.dart';
import 'services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  final CountryInfoThemeService _themeService = CountryInfoThemeService();

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final themeMode = await _themeService.getThemeMode();
    if (mounted) {
      setState(() {
        _themeMode = themeMode;
      });
    }
  }

  void _toggleTheme(bool isDark) async {
    await _themeService.setThemeMode(isDark);
    if (mounted) {
      setState(() {
        _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(onThemeToggle: _toggleTheme),
    );
  }
}