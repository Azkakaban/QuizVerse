import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const QuizVerseApp());
}

class QuizVerseApp extends StatefulWidget {
  const QuizVerseApp({super.key});

  @override
  State<QuizVerseApp> createState() => _QuizVerseAppState();
}

class _QuizVerseAppState extends State<QuizVerseApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizVerse',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      themeAnimationDuration: Duration.zero,
      home: WelcomeScreen(
        onThemeToggle: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}