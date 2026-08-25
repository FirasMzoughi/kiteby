import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class _Comment {
  final String name;
  final String message;
  final String time;
  final int likes;
  const _Comment(this.name, this.message, this.time, this.likes);
}

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  static const _comments = [
    _Comment('Ahmed', 'Great shot! I love it', '2 mins ago', 2),
    _Comment('Ahmed', 'Great shot! I love it', '2 mins ago', 2),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1F8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_left, color: kPrimaryBlue),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFD7E1EA),
                        child: Icon(Icons.person, color: kPrimaryBlue),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Samira',
                        style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryBlue, fontSize: 15),
                      ),
                      const Spacer(),
                      const Text('1 hour ago', style: TextStyle(color: kTextGrey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Street portrait',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryBlue),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing '
                    'elit. Quis risus, neque cursus risus. Eget dictumst '
                    'vitae enim, felis morbi. Quis risus, neque cursus risus. '
                    'Eget dictumst vitae enim, felis morbi. Quis risus, neque '
                    'cursus risus.',
                    style: TextStyle(color: kTextGrey, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      color: const Color(0xFF20232A),
                      child: const Center(
                        child: Icon(Icons.menu_book_outlined, color: Colors.white54, size: 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _stat(Icons.remove_red_eye_outlined, '125'),
                      const SizedBox(width: 20),
                      _stat(Icons.chat_bubble_outline, '20'),
                      const SizedBox(width: 20),
                      _stat(Icons.favorite_border, '125'),
                      const Spacer(),
                      _stat(Icons.share_outlined, '125'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: kFieldBorder),
                  const SizedBox(height: 8),
                  ..._comments.map((c) => _buildComment(c)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: kPrimaryBlue),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(color: kPrimaryBlue, fontSize: 13)),
      ],
    );
  }

  Widget _buildComment(_Comment comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFD7E1EA),
            child: Icon(Icons.person, color: kPrimaryBlue, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3F8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: kPrimaryBlue, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(comment.message, style: const TextStyle(color: kPrimaryBlue, fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(comment.time, style: const TextStyle(color: kTextGrey, fontSize: 11)),
                      const SizedBox(width: 12),
                      const Text('Like', style: TextStyle(color: kPrimaryBlue, fontSize: 11, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('${comment.likes}', style: const TextStyle(color: kTextGrey, fontSize: 11)),
                      const SizedBox(width: 4),
                      const Icon(Icons.favorite, color: kPrimaryBlue, size: 14),
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

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kFieldBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F5F8),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _commentController,
                  style: const TextStyle(color: kPrimaryBlue, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Type something',
                    hintStyle: TextStyle(color: kTextGrey, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _commentController.clear();
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Post', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
