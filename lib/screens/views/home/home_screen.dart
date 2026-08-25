import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';
import 'package:kiteby/screens/views/home/book_detail_screen.dart';
import 'package:kiteby/screens/views/menu/menu_screen.dart';
import 'package:kiteby/screens/views/notifications/notifications_screen.dart';
import 'package:kiteby/screens/views/profile/profile_screen.dart';
import 'package:kiteby/screens/views/rooms/calling_rooms_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _BookInfo {
  final String title;
  final String author;
  final Color color;
  final double rating;
  final String reviews;
  const _BookInfo(this.title, this.author, this.color, this.rating, this.reviews);
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  int _recommendedPage = 1;

  static const _recommended = [
    _BookInfo('Steal Like An Artist', 'Austin Kleon', Color(0xFF161616), 5.0, '23k'),
    _BookInfo('The Alchemist', 'Paulo Coelho', Color(0xFFE0782D), 5.0, '23k'),
    _BookInfo('The Psychology of Money', 'Morgan Housel', Color(0xFFF4F1EA), 4.8, '487'),
    _BookInfo('7 Habits of Highly Effective People', 'Stephen R. Covey', Color(0xFF1F3A5F), 4.9, '15k'),
  ];

  static const _popular = [
    _BookInfo('The Steal Like An Artist', 'Austin Kleon', Color(0xFF161616), 5.0, '23k'),
    _BookInfo('A Million To One', 'Tony Faggioli', Color(0xFFEDEDED), 4.1, '17k'),
    _BookInfo('The Steal Like An Artist', 'Austin Kleon', Color(0xFF161616), 5.0, '23k'),
    _BookInfo('Book Name', "Auther's Name", Color(0xFFD9D9D9), 5.0, '23k'),
  ];

  void _openBook(BuildContext context, _BookInfo book) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookDetailScreen(title: book.title, color: book.color)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 20),
            _sectionTitle('Book of the week'),
            const SizedBox(height: 10),
            _buildBookOfWeek(context),
            const SizedBox(height: 20),
            _sectionTitle('Recommended for you'),
            const SizedBox(height: 10),
            _buildRecommendedCarousel(context),
            const SizedBox(height: 8),
            _buildDots(3, _recommendedPage),
            const SizedBox(height: 20),
            _sectionTitle('Popular books'),
            const SizedBox(height: 10),
            ..._popular.map((b) => _buildPopularRow(context, b)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: kFieldBorder),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: kTextGrey, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Search books, Authers or User',
                      style: TextStyle(color: kTextGrey, fontSize: 13)),
                ),
                const Icon(Icons.camera_alt_outlined, color: kTextGrey, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kFieldBorder),
            ),
            child: const Icon(Icons.person_outline, color: kTextGrey),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue),
    );
  }

  Widget _buildBookOfWeek(BuildContext context) {
    const book = _BookInfo('Rich Dad Poor Dad', 'Robert T. Kiyosaki', Color(0xFF3B2E86), 4.6, '');
    return GestureDetector(
      onTap: () => _openBook(context, book),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 100,
              decoration: BoxDecoration(color: book.color, borderRadius: BorderRadius.circular(8)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rich Dad Poor Dad',
                      style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 15)),
                  const SizedBox(height: 6),
                  const Text(
                    'Rich Dad Poor Dad explores the difference in mindset between the wealthy and the poor. It emphasizes financial education, smart investing, and making money work for you, rather than just working for money.',
                    style: TextStyle(color: kTextGrey, fontSize: 11, height: 1.4),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _openBook(context, book),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text('Read Now', style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () => _openBook(context, book),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                        child: const Text('Learn More', style: TextStyle(color: kPrimaryBlue, fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedCarousel(BuildContext context) {
    return SizedBox(
      height: 150,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final maxScroll = notification.metrics.maxScrollExtent;
            final offset = notification.metrics.pixels;
            final page = maxScroll == 0 ? 0 : ((offset / maxScroll) * 2).round();
            if (page != _recommendedPage) {
              setState(() => _recommendedPage = page);
            }
          }
          return false;
        },
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _recommended.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final book = _recommended[index];
            return GestureDetector(
              onTap: () => _openBook(context, book),
              child: Container(
                width: 95,
                decoration: BoxDecoration(color: book.color, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomLeft,
                child: Text(
                  book.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDots(int count, int active) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == active ? kPrimaryBlue : kFieldBorder,
          ),
        );
      }),
    );
  }

  Widget _buildPopularRow(BuildContext context, _BookInfo book) {
    return GestureDetector(
      onTap: () => _openBook(context, book),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 68,
              decoration: BoxDecoration(color: book.color, borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 13)),
                  Text(book.author, style: const TextStyle(color: kTextGrey, fontSize: 11)),
                  const SizedBox(height: 4),
                  Text('${book.rating} | Based on ${book.reviews} Reviews',
                      style: const TextStyle(color: kTextGrey, fontSize: 10)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _openBook(context, book),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    minimumSize: Size.zero,
                  ),
                  child: const Text('Read Now', style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () => _openBook(context, book),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  child: const Text('Learn More', style: TextStyle(color: kPrimaryBlue, fontSize: 11)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryBlue,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navIcon(Icons.home, 0, () => setState(() => _navIndex = 0)),
            _navIcon(Icons.menu_book_outlined, 1, () => setState(() => _navIndex = 1)),
            _buildCenterFab(context),
            _navIcon(Icons.notifications_none, 2, () {
              setState(() => _navIndex = 2);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            }),
            _navIcon(Icons.menu, 3, () {
              setState(() => _navIndex = 3);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MenuScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index, VoidCallback onTap) {
    final selected = index == _navIndex;
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: selected ? Colors.white : Colors.white54, size: 24),
    );
  }

  Widget _buildCenterFab(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CallingRoomsScreen()),
        );
      },
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: const Icon(Icons.menu_book, color: kPrimaryBlue),
      ),
    );
  }
}
