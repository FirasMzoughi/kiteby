import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';
import 'package:kiteby/screens/views/profile/author_profile_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final String title;
  final Color color;

  const BookDetailScreen({super.key, required this.title, required this.color});

  void _openRatingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _RatingsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Stack(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            color: color,
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.chevron_left, color: kPrimaryBlue),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90,
                        height: 130,
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: kPrimaryBlue,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                              const SizedBox(height: 6),
                              const Text(
                                'The psychology of money is the study of our behavior with money. Success with money isn\'t about knowledge, IQ or how good you are at math. It\'s about behavior, and everyone is prone to certain behaviors over others.',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white70, fontSize: 10, height: 1.3),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () => _openRatingsSheet(context),
                                child: Row(
                                  children: [
                                    ...List.generate(5, (i) => const Icon(Icons.star, color: Colors.amber, size: 14)),
                                    const SizedBox(width: 6),
                                    const Text('(5.0)', style: TextStyle(color: Colors.white, fontSize: 11)),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () => _openRatingsSheet(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kLightBlue,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        minimumSize: Size.zero,
                                      ),
                                      child: const Text('Write a review', style: TextStyle(color: Colors.white, fontSize: 9)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AuthorProfileScreen()),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: kPrimaryBlue, borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 22, backgroundColor: kFieldBorder, child: Icon(Icons.person, color: kPrimaryBlue)),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Author', style: TextStyle(color: Colors.white70, fontSize: 11)),
                                Text('Morgan Housel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                                Text('Best Seller of New York Times', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              ],
                            ),
                          ),
                          const Icon(Icons.star_border, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('About The Book',
                          style: TextStyle(color: kTextGrey, fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 8),
                      const Text(
                        "'The Psychology of Money' is an essential read for anyone interested in being better with money. Fast-paced and engaging, this book will help you refine your thoughts towards money. You can finish this book in a week, unlike other books that are too lengthy.\n\nThe most important emotions in relation to money are fear, guilt, shame and envy. It's worth spending some effort to become aware of the emotions that are especially tied to money for you because, without awareness, they will tend to override rational thinking and drive your actions.",
                        style: TextStyle(color: kTextGrey, fontSize: 12, height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      const Text('Books Thesis',
                          style: TextStyle(color: kTextGrey, fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 10),
                      ...List.generate(2, (i) => _thesisCard()),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: kFieldBorder)),
                    child: const Icon(Icons.bookmark_border, color: kPrimaryBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('Read Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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

  Widget _thesisCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
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
          const SizedBox(height: 10),
          Row(
            children: const [
              Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
              SizedBox(width: 4),
              Icon(Icons.favorite_border, size: 16, color: kPrimaryBlue),
              SizedBox(width: 16),
              Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
              SizedBox(width: 4),
              Icon(Icons.chat_bubble_outline, size: 16, color: kPrimaryBlue),
              SizedBox(width: 16),
              Text('125', style: TextStyle(fontSize: 12, color: kPrimaryBlue)),
              SizedBox(width: 4),
              Icon(Icons.share_outlined, size: 16, color: kPrimaryBlue),
              Spacer(),
              Icon(Icons.menu_book_outlined, size: 20, color: kPrimaryBlue),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingsSheet extends StatefulWidget {
  const _RatingsSheet();

  @override
  State<_RatingsSheet> createState() => _RatingsSheetState();
}

class _RatingsSheetState extends State<_RatingsSheet> {
  int _selectedScore = 4;

  static const _breakdown = [
    (5, 0.85),
    (4, 0.55),
    (3, 0.25),
    (2, 0.15),
    (1, 0.05),
  ];

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
            alignment: Alignment.center,
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
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Ratings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextGrey)),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: _breakdown.map((entry) {
                    final (score, value) = entry;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Text('$score', style: const TextStyle(color: kTextGrey, fontSize: 12)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 8,
                                backgroundColor: kFieldBorder,
                                valueColor: const AlwaysStoppedAnimation(Colors.amber),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('4.8', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
                  Text('487 Reviews', style: TextStyle(fontSize: 11, color: kTextGrey)),
                  SizedBox(height: 12),
                  Text('89%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
                  Text('Recommended', style: TextStyle(fontSize: 11, color: kTextGrey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Select a score', style: TextStyle(color: kTextGrey, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(5, (index) {
                final filled = index < _selectedScore;
                return GestureDetector(
                  onTap: () => setState(() => _selectedScore = index + 1),
                  child: Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 28,
                  ),
                );
              }),
              const Spacer(),
              Container(
                width: 60,
                height: 32,
                decoration: BoxDecoration(color: const Color(0xFFE9E6D8), borderRadius: BorderRadius.circular(8)),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
        ],
      ),
    );
  }
}
