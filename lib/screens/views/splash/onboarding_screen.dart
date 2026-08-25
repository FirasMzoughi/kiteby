import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiteby/screens/views/welcome/welcome-secreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _Language {
  final String code;
  final String label;
  final String flag;
  const _Language(this.code, this.label, this.flag);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showLanguageMenu = false;

  static const List<_Language> _languages = [
    _Language('AR', 'العربية', '🇹🇳'),
    _Language('EN', 'English', '🇬🇧'),
    _Language('FR', 'Français', '🇫🇷'),
    _Language('ES', 'Español', '🇪🇸'),
    _Language('RU', 'Русский', '🇷🇺'),
    _Language('ZH', '中文', '🇨🇳'),
  ];

  _Language _selectedLanguage = _languages[1];

  final List<Map<String, String>> _pageContent = const [
    {
      'svgPath': 'assets/icons/books.svg',
      'title': 'Read Books',
      'description':
          'Books can help you to increase your knowledge\nand become more successfully.',
    },
    {
      'svgPath': 'assets/icons/review.svg',
      'title': 'Review Them',
      'description':
          'Review books, share insights, and connect with\nreaders and authors!',
    },
    {
      'svgPath': 'assets/icons/share.svg',
      'title': 'Share, Make Friends',
      'description':
          'Books are our true friends in life. They have the\npower to transform us and add value to who we are.\n\nSo, let\'s make friends!',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToWelcome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _onNextPressed() {
    if (_currentPage < _pageContent.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _goToWelcome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // White background
          Container(color: Colors.white),

          // Decorative gradient blobs
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3E76AF), Color(0xFF95DEF2)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 40,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2DEEF9), Color(0xFF3A54A5)],
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
                  colors: [Color(0xFFADD8E6), Color(0xFF87CEFA)],
                ),
              ),
            ),
          ),

          // Page content
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pageContent.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _showLanguageMenu = false;
                });
              },
              itemBuilder: (context, index) {
                final page = _pageContent[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF47BADF),
                              Color(0xFF49C7E8),
                              Color(0xFF2D517D),
                            ],
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            page['svgPath']!,
                            width: 90,
                            height: 90,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        page['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3A6B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3A6B),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Language selector. Must come after the PageView in this Stack, or
          // the full-screen PageView sits on top of it and eats the taps.
          Positioned(
            top: 40,
            right: 20,
            child: _buildLanguageSelector(),
          ),

          // Bottom section: dots, next button, skip intro
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(_pageContent.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: index == _currentPage ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: index == _currentPage
                                  ? const Color(0xFF2D3A6B)
                                  : const Color(0xFFD6E4F0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF2AA2CD), Color(0xFF4CDAFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: FloatingActionButton(
                          onPressed: _onNextPressed,
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _goToWelcome,
                    child: const Text(
                      'Skip Intro',
                      style: TextStyle(
                        color: Color(0xFF2D3A6B),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF46D0F6), Color(0xFF297A90)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() {
                  _showLanguageMenu = !_showLanguageMenu;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.language, color: Colors.white, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      _selectedLanguage.code,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_showLanguageMenu) ...[
          const SizedBox(height: 8),
          Container(
            width: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _languages.map((lang) {
                final bool selected = lang.code == _selectedLanguage.code;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang;
                      _showLanguageMenu = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEAF6FB)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            lang.label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: const Color(0xFF2D3A6B),
                            ),
                          ),
                        ),
                        Text(lang.flag, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
