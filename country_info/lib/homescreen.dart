import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country Info"),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              widget.onThemeToggle(value);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Welcome to Country Info App!"),
      ),
    );
  }
}
