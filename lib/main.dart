import 'package:flutter/material.dart';
import 'package:tic_tac_game/screens/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF00061A),
        splashColor: const Color(0xFF4169e8),
        shadowColor: const Color(0xFF001456),
      ),
      home:const MyHomePage(),
    );
  }
}
