import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const QuizVerseApp());
}

class QuizVerseApp extends StatelessWidget {
  const QuizVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizVerse',
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}