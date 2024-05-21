import 'package:flutter/material.dart';
import 'package:pobe/splash/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PoBe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(31, 54, 113, 1)),
        useMaterial3: true,
      ),
      home: const SplashScreenWelcome(),
    );
  }
}
