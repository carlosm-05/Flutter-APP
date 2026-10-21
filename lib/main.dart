import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TallerApp());
}

class TallerApp extends StatelessWidget {
  const TallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login y Registro',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFFAF9FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB338D9)),
      ),
      home: const LoginScreen(),
    );
  }
}
