import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _getStarted(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient blobs
          Positioned(
            top: -60,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4CDAFF), Color(0xFF2AA2CD)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF87CEFA).withValues(alpha: 0.35),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Expanded(child: _BookCollage()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Book Has Power To Change\nEverything',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3A6B),
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _getStarted(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2AA2CD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 4,
                      ).copyWith(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.transparent),
                        shadowColor: WidgetStateProperty.all(
                          const Color(0xFF2AA2CD).withValues(alpha: 0.4),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF005C8D),
                              Color(0xFF2AA2CD),
                              Color(0xFF4CDAFF),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: const Center(
                          child: Text(
                            'Get Started Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookData {
  final String title;
  final String author;
  final Color color;
  final Color textColor;
  const _BookData(this.title, this.author, this.color, {this.textColor = Colors.white});
}

class _BookCollage extends StatelessWidget {
  const _BookCollage();

  static const List<_BookData> _books = [
    _BookData('The Psychology\nof Money', 'Morgan Housel', Color(0xFFF4F1EA),
        textColor: Color(0xFF2D3A6B)),
    _BookData('7 Habits of Highly\nEffective People', 'Stephen R. Covey',
        Color(0xFF1F3A5F)),
    _BookData('The Alchemist', 'Paulo Coelho', Color(0xFFE0782D)),
    _BookData('Steal Like\nAn Artist', 'Austin Kleon', Color(0xFF161616)),
    _BookData('Ikigai', 'Héctor García', Color(0xFFDCEEF2),
        textColor: Color(0xFF2D3A6B)),
    _BookData('Rich Dad\nPoor Dad', 'Robert Kiyosaki', Color(0xFF3B2E86)),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: constraints.maxWidth * 0.02,
              top: 10,
              child: _bookCard(_books[0], 110, 150),
            ),
            Positioned(
              right: constraints.maxWidth * 0.02,
              top: 0,
              child: _bookCard(_books[2], 120, 170),
            ),
            Positioned(
              left: constraints.maxWidth * 0.06,
              bottom: 20,
              child: _bookCard(_books[3], 100, 130),
            ),
            Positioned(
              top: 90,
              child: _bookCard(_books[1], 100, 140),
            ),
            Positioned(
              bottom: 30,
              child: _bookCard(_books[4], 95, 120),
            ),
            Positioned(
              right: constraints.maxWidth * 0.06,
              bottom: 10,
              child: _bookCard(_books[5], 110, 150),
            ),
          ],
        );
      },
    );
  }

  Widget _bookCard(_BookData book, double width, double height) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: book.color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flexible + ellipsis: several titles wrap to multiple lines and
          // would otherwise overflow these fixed-height cards on short screens.
          Flexible(
            child: Text(
              book.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                color: book.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: book.textColor.withValues(alpha: 0.85),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
