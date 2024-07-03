
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Default theme
      darkTheme: ThemeData.dark(), // Dark theme
      home: const DarkLightModeToggle(),
    );
  }
}

class DarkLightModeToggle extends StatefulWidget {
  const DarkLightModeToggle({super.key});

  @override
  _DarkLightModeToggleState createState() => _DarkLightModeToggleState();
}

class _DarkLightModeToggleState extends State<DarkLightModeToggle> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void toggleTheme(bool newMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = newMode;
      prefs.setBool('isDarkMode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dark/Light Mode')),
      body: Center(
        child: Switch(
          value: isDarkMode,
          onChanged: (newValue) {
            toggleTheme(newValue);
          },
        ),
      ),
    );
  }
}
