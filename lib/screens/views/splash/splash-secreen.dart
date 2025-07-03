import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiteby/screens/views/splash/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _shapeScaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Shape scale animation
    _shapeScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start animations
    _controller.forward();

    // Navigate to onboarding after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1800), () {
  if (mounted) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800), // المدة
        pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
});

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background (white)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          // First abstract shape (top-left) with gradient #FFFFFF to #49C7E8
          Positioned(
            top: -50,
            left: -50,
            child: ScaleTransition(
              scale: _shapeScaleAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF), // #FFFFFF (White)
                      Color(0xFF49C7E8), // #49C7E8 (Light blue/cyan)
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Second abstract shape (bottom-right) with gradient #49C7E8 to #3C6CA8
          Positioned(
            bottom: -100,
            right: -100,
            child: ScaleTransition(
              scale: _shapeScaleAnimation,
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF49C7E8), // #49C7E8 (Light blue/cyan)
                      Color(0xFF3C6CA8), // #3C6CA8 (Darker blue)
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Third abstract shape (top-right) with gradient #447ABE to #1F3958
          Positioned(
            top: 100,
            right: -50,
            child: ScaleTransition(
              scale: _shapeScaleAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF447ABE), // #447ABE (Medium blue)
                      Color(0xFF1F3958), // #1F3958 (Dark blue)
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Centered SVG logo with fade animation
          Center(
            child: FadeTransition(
              opacity: _logoFadeAnimation,
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 200,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}