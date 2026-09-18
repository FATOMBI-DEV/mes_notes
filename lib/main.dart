import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MesNotesApp());
}

class MesNotesApp extends StatelessWidget {
  const MesNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}