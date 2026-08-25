import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class AuthorProfileScreen extends StatefulWidget {
  const AuthorProfileScreen({super.key});

  @override
  State<AuthorProfileScreen> createState() => _AuthorProfileScreenState();
}

enum _AuthorTab { posts, theses, books }

class _AuthorProfileScreenState extends State<AuthorProfileScreen> {
  _AuthorTab _tab = _AuthorTab.posts;
  bool _isFollowing = true;

  static const List<Color> _bookColors = [
    Color(0xFFE9A46B),
    Color(0xFFD9E6D8),
    Color(0xFFD9D9D9),
    Color(0xFFD9D9D9),
    Color(0xFFD9D9D9),
    Color(0xFFD9D9D9),
  ];

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
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.chevron_left, color: kPrimaryBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 34,
                      backgroundColor: kFieldBorder,
                      child: Icon(Icons.person, color: kPrimaryBlue, size: 32),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(color: Color(0xFF2E9EF0), shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          _StatColumn(value: '2.7K', label: ''),
                          _StatColumn(value: '28', label: ''),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                onPressed: () => setState(() => _isFollowing = !_isFollowing),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFollowing ? kLightBlue : kPrimaryBlue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(_isFollowing ? 'Followed' : 'Follow',
                                    style: const TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryBlue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text('Following', style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Morgan Housel',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
                      Text('Author', style: TextStyle(color: kTextGrey, fontSize: 13)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text('(5.0)', style: TextStyle(color: kTextGrey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Contact Now', style: TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('About The Auther',
                style: TextStyle(color: kTextGrey, fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            const Text(
              'Morgan Housel is an American author and financial expert renowned for his insights into behavioral finance and investing. He earned a Bachelor of Arts in Economics from the University of Southern California in 2008. Housel began his career as a columnist for The Motley Fool and contributed to The Wall Street Journal, focusing on financial topics.\n\nHe\'s now a partner at The Collaborative Fund, where he focuses on investing and human behavior. His writing highlights that financial success comes more from good habits and clear thinking than from high income or intelligence.',
              style: TextStyle(color: kTextGrey, fontSize: 12, height: 1.5),
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
      (_AuthorTab.posts, 'Postes'),
      (_AuthorTab.theses, 'Thieses'),
      (_AuthorTab.books, 'Books'),
    ];
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: tabs.map((entry) {
          final (tab, label) = entry;
          final selected = tab == _tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _tab = tab),
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
                    fontSize: 12,
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
      case _AuthorTab.books:
        return _buildBooksGrid();
      case _AuthorTab.theses:
        return _buildThesesTab();
      case _AuthorTab.posts:
        return _buildPostsTab();
    }
  }

  Widget _buildBooksGrid() {
    const titles = ['Same as Ever', 'The Psycolo...', '', '', '', ''];
    const ratings = ['4.0', '4.0', '4.0', '4.0', '4.0', '4.0'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _bookColors.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: _bookColors[index], borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 12),
                const SizedBox(width: 4),
                Text(ratings[index], style: const TextStyle(color: kTextGrey, fontSize: 11)),
              ],
            ),
            if (titles[index].isNotEmpty)
              Text(titles[index], style: const TextStyle(color: kPrimaryBlue, fontSize: 12, fontWeight: FontWeight.w600))
            else
              Container(height: 10, width: 60, color: kFieldBorder, margin: const EdgeInsets.only(top: 2)),
            const SizedBox(height: 2),
            Row(
              children: [
                const Text('Learn More', style: TextStyle(color: kTextGrey, fontSize: 10)),
                const Spacer(),
                const Icon(Icons.arrow_forward, color: kTextGrey, size: 12),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildThesesTab() {
    return Column(
      children: List.generate(2, (i) => _thesisCard()),
    );
  }

  Widget _thesisCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 16, backgroundColor: kFieldBorder, child: Icon(Icons.person, size: 16, color: kPrimaryBlue)),
              const SizedBox(width: 8),
              const Text('Morgan Housel', style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryBlue, fontSize: 13)),
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
          const SizedBox(height: 10),
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
            'The book explains how factors like luck, risk, saving discipline, and emotional control shape financial outcomes. Housel highlights common psychological biases—like overconfidence wealth ...See more',
            style: TextStyle(color: kTextGrey, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return Column(
      children: List.generate(2, (index) => _postPreview()),
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
              Text('Morgan Housel', style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryBlue, fontSize: 13)),
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
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
          if (label.isNotEmpty) Text(label, style: const TextStyle(fontSize: 11, color: kTextGrey)),
        ],
      ),
    );
  }
}
