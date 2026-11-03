import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyCotaiApp());
}

class MyCotaiApp extends StatelessWidget {
  const MyCotaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCotai ID',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData().textTheme,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}