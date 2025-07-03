import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // White background
          Container(
            color: Colors.white,
          ),
          // Abstract shape overlays
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3E76AF), // Light sky blue#3E76AF
                    Color(0xFF95DEF2), // Steel blue#95DEF2
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2DEEF9), // Steel blue#2DEEF9
                    Color(0xFF3A54A5), // Dodger blue#3A54A5
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFADD8E6), // Light blue
                    Color(0xFF87CEFA), // Light cyan
                  ],
                ),
              ),
            ),
          ),
          // Language button (top-right)
          Positioned(
  top: 20,
  right: 20,
  child: Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF46D0F6), // #46D0F6
          Color(0xFF297A90), // #297A90
        ],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // Add language toggle logic here
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8), 
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: Colors.white,
                size: 23,
              ),
              SizedBox(width: 8), 
              Text(
                'EN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),

          // Centered SVG logo
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
  Color(0xFF47BADF), // #47BADF
  Color(0xFF49C7E8), // #49C7E8
  Color(0xFF2D517D), // #2D517D
],

                ),
              ),
              child: Center(
  child: SvgPicture.asset(
    'assets/icons/logo.svg',
    width: 150,
    height: 150,
    color: Colors.white, 
  ),
),

            ),
          ),
          // Bottom section: Text, dots, and Next button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Books can help you to increase your knowledge\nand become more successfully.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4682B4), // Steel blue
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Page indicator dots
                      Row(
                        children: List.generate(4, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: index == 0 ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? const Color(0xFF4682B4) // Active dot (steel blue)
                                  : const Color(0xFFE6E6E6), // Inactive dots (light gray)
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 40),
                      // Next button
                      Container(
  width: 56,
  height: 56,
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: [
        Color(0xFF005C8D), // #005C8D
        Color(0xFF2AA2CD), // #2AA2CD
        Color(0xFF4CDAFF), // #4CDAFF
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: FloatingActionButton(
    onPressed: () {
      // Navigator.pushNamed(context, '/home');
    },
    backgroundColor: Colors.transparent,
    elevation: 0,
    child: const Icon(
      Icons.arrow_forward,
      color: Colors.white,
    ),
  ),
),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}