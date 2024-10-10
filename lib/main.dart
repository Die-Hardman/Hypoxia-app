import 'package:flutter/material.dart';
import 'package:frontdiplom/screens/MainScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(), // Встановлюємо гарний шрифт для всього додатку
        primarySwatch: Colors.teal,
      ),
      home: MainScreen(),
    );
  }
}