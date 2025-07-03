import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/splash/onboarding_screen.dart';
import 'package:kiteby/screens/views/splash/splash-secreen.dart';

void main() {
  runApp(const KitebyApp());
}

class KitebyApp extends StatelessWidget {
  const KitebyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiteby',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0070FF), 
          brightness: Brightness.light, 
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
    );
  }
}
