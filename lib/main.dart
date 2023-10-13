import 'package:flutter/material.dart';
import 'package:free_palastine/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              minimumSize: const Size(double.infinity, 38),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
