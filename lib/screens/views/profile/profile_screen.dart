import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

enum _ProfileTab { posts, theses, myBooks, addBooks }

class _BookProgress {
  final String title;
  final String author;
  final double progress;
  final Color color;
  const _BookProgress(this.title, this.author, this.progress, this.color);
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileTab _tab = _ProfileTab.myBooks;

  static const _books = [
    _BookProgress('A Day of Fallen Night', 'Samantha Shannon', 0.30, Color(0xFF1F3A5F)),
    _BookProgress('Ninth House', 'Leigh Bardugo', 0.71, Color(0xFF111111)),
    _BookProgress('A Day of Fallen Night', 'Samantha Shannon', 0.30, Color(0xFF1F3A5F)),
  ];

  void _openAddBooksSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AddBooksSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.chevron_left, color: kPrimaryBlue, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: kFieldBorder,
                ),
                child: const Icon(Icons.person, color: kPrimaryBlue, size: 44),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Morgan Housel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue),
              ),
            ),
            const Center(
              child: Text('Auther', style: TextStyle(color: kTextGrey, fontSize: 13)),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined, size: 14, color: kTextGrey),
                  SizedBox(width: 4),
                  Text('Tunisia, Tunisie', style: TextStyle(color: kTextGrey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatColumn(value: '122', label: 'followers'),
                _StatColumn(value: '67', label: 'following'),
                _StatColumn(value: '37K', label: 'likes'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _outlinedButton('Edit profile', () {})),
                const SizedBox(width: 12),
                Expanded(child: _outlinedButton('Add friends', () {})),
              ],
            ),
            const SizedBox(height: 20),
            _buildTabBar(),
            const SizedBox(height: 16),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = [
      (_ProfileTab.posts, 'Postes'),
      (_ProfileTab.theses, 'Thieses'),
      (_ProfileTab.myBooks, 'My Books'),
      (_ProfileTab.addBooks, 'Add Books'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: tabs.map((entry) {
          final (tab, label) = entry;
          final selected = tab == _tab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _tab = tab);
                if (tab == _ProfileTab.addBooks) {
                  _openAddBooksSheet();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? kPrimaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? Colors.white : kTextGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_tab) {
      case _ProfileTab.myBooks:
        return _buildMyBooksTab();
      case _ProfileTab.theses:
        return _buildThesesTab();
      case _ProfileTab.posts:
        return _buildPostsTab();
      case _ProfileTab.addBooks:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMyBooksTab() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFDCEBFA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('In progress', style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          ),
          const SizedBox(height: 16),
          ..._books.map((b) => _buildBookRow(b)),
        ],
      ),
    );
  }

  Widget _buildBookRow(_BookProgress book) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(color: book.color, borderRadius: BorderRadius.circular(6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 14)),
                Text(book.author, style: const TextStyle(color: kTextGrey, fontSize: 12)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: book.progress,
                    minHeight: 6,
                    backgroundColor: kFieldBorder,
                    valueColor: const AlwaysStoppedAnimation(kPrimaryBlue),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('${(book.progress * 100).round()}%', style: const TextStyle(color: kTextGrey, fontSize: 11)),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text('Update Progress', style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThesesTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kFieldBorder),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: kTextGrey),
              SizedBox(width: 8),
              Text('Add new thies', style: TextStyle(color: kTextGrey, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 16, backgroundColor: kFieldBorder, child: Icon(Icons.person, size: 16, color: kPrimaryBlue)),
                  const SizedBox(width: 8),
                  const Text('Ahmed Ahmed', style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryBlue, fontSize: 13)),
                  const Spacer(),
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const Text(' (5.0)', style: TextStyle(color: kTextGrey, fontSize: 12)),
                  const SizedBox(width: 6),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(color: kPrimaryBlue, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Thesis Statement:', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 13)),
              const SizedBox(height: 4),
              const Text(
                'In The Psychology of Money, Morgan Housel argues that financial success is less about knowledge and more about behavior. Emotions, patience, and decision-making habits play a bigger role in wealth-building than technical skills or intelligence.',
                style: TextStyle(color: kTextGrey, fontSize: 12, height: 1.4),
              ),
              const SizedBox(height: 8),
              const Text('Summary:', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 13)),
              const SizedBox(height: 4),
              const Text(
                'The book explains how factors like luck, risk, saving discipline, and psychological patterns shape financial outcomes...See more',
                style: TextStyle(color: kTextGrey, fontSize: 12, height: 1.4),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFF2F5F8), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(width: 36, height: 48, color: const Color(0xFFF4F1EA)),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('The Psychology of Money', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: kPrimaryBlue)),
                          Text('Morgan Housel', style: TextStyle(color: kTextGrey, fontSize: 11)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Go to book', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.favorite_border, size: 16, color: kPrimaryBlue),
                  SizedBox(width: 4),
                  Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
                  SizedBox(width: 16),
                  Icon(Icons.chat_bubble_outline, size: 16, color: kPrimaryBlue),
                  SizedBox(width: 4),
                  Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
                  SizedBox(width: 16),
                  Icon(Icons.share_outlined, size: 16, color: kPrimaryBlue),
                  SizedBox(width: 4),
                  Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
                  Spacer(),
                  Icon(Icons.bookmark_border, size: 16, color: kPrimaryBlue),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kFieldBorder),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: kTextGrey),
              SizedBox(width: 8),
              Text('Add new Poste', style: TextStyle(color: kTextGrey, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(2, (index) => _postPreview()),
      ],
    );
  }

  Widget _postPreview() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(radius: 16, backgroundColor: kFieldBorder, child: Icon(Icons.person, size: 16, color: kPrimaryBlue)),
              SizedBox(width: 8),
              Text('Ahmed Ahmed', style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryBlue, fontSize: 13)),
              Spacer(),
              Text('1 hour ago', style: TextStyle(color: kTextGrey, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 130,
              width: double.infinity,
              color: const Color(0xFF20232A),
              child: const Center(child: Icon(Icons.menu_book_outlined, color: Colors.white54, size: 32)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.add_circle_outline, size: 16, color: kPrimaryBlue),
              SizedBox(width: 4),
              Text('See more', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
              Spacer(),
              Icon(Icons.chat_bubble_outline, size: 16, color: kPrimaryBlue),
              SizedBox(width: 4),
              Text('20', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
              SizedBox(width: 16),
              Icon(Icons.favorite_border, size: 16, color: kPrimaryBlue),
              SizedBox(width: 4),
              Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _outlinedButton(String label, VoidCallback onTap) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
        Text(label, style: const TextStyle(fontSize: 12, color: kTextGrey)),
      ],
    );
  }
}

class _AddBooksSheet extends StatelessWidget {
  const _AddBooksSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kFieldBorder)),
                child: const Icon(Icons.close, size: 18, color: kPrimaryBlue),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Add Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(height: 60, decoration: BoxDecoration(color: const Color(0xFFEAF1F8), borderRadius: BorderRadius.circular(10))),
                    const SizedBox(height: 10),
                    Container(height: 60, decoration: BoxDecoration(color: const Color(0xFFEAF1F8), borderRadius: BorderRadius.circular(10))),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 134,
                  decoration: BoxDecoration(color: const Color(0xFFEAF1F8), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.add_circle, color: kPrimaryBlue, size: 32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kFieldBorder),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Cancel', style: TextStyle(color: kTextGrey)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kLightBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Post Now', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
