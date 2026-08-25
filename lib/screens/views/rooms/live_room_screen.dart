import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class _Participant {
  final String name;
  final Color color;
  final bool muted;
  const _Participant(this.name, this.color, {this.muted = true});
}

class LiveRoomScreen extends StatefulWidget {
  const LiveRoomScreen({super.key});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  bool _showChat = false;
  bool _muted = true;

  static const _participants = [
    _Participant('Mike', Color(0xFFE0A83B)),
    _Participant('Samir', Color(0xFF6B6B6B)),
    _Participant('Oumayma', Color(0xFFB98A5E), muted: false),
    _Participant('Nedra', Color(0xFFC9A98B)),
    _Participant('Ahmed', Color(0xFF3B6E63)),
    _Participant('Amira', Color(0xFF4A4A4A)),
  ];

  static const _chatMessage =
      'Hello guys, we have discussed about post-corona vacation plan and our decision is to go to Bali. We will have a very big party after this corona ends! These are some images about our destination';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.chevron_left, color: kPrimaryBlue),
                    ),
                    const SizedBox(width: 4),
                    const CircleAvatar(radius: 14, backgroundColor: Color(0xFFE9C08A)),
                    const SizedBox(width: 8),
                    const Text('Book Online Room',
                        style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 15)),
                  ],
                ),
              ),
            ),
            const Text('30:21', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 110,
                  width: double.infinity,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          '1\nWhen Harry Met Caroline\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit...',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 9, color: kTextGrey),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kFieldBorder), color: Colors.white),
                          child: const Icon(Icons.add, size: 14, color: kPrimaryBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFDCEBFA), borderRadius: BorderRadius.circular(20)),
                  child: _showChat ? _buildChatOverlay() : _buildParticipantsGrid(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildControlBar(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantsGrid() {
    return GridView.builder(
      itemCount: _participants.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        if (index == _participants.length) {
          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFC7DCEF)),
                child: const Icon(Icons.add, color: kPrimaryBlue),
              ),
            ],
          );
        }
        final p = _participants[index];
        return Column(
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 28, backgroundColor: p.color, child: const Icon(Icons.person, color: Colors.white)),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Icon(p.muted ? Icons.mic_off : Icons.mic, size: 12, color: kPrimaryBlue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(p.name, style: const TextStyle(color: kPrimaryBlue, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        );
      },
    );
  }

  Widget _buildChatOverlay() {
    return ListView(
      children: [
        _chatBubble(isMe: false),
        const SizedBox(height: 12),
        _chatBubble(isMe: true),
        const SizedBox(height: 12),
        _chatBubble(isMe: false),
      ],
    );
  }

  Widget _chatBubble({required bool isMe}) {
    final avatar = CircleAvatar(radius: 16, backgroundColor: kFieldBorder, child: const Icon(Icons.person, size: 16, color: kPrimaryBlue));
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: const Text(_chatMessage, style: TextStyle(color: kPrimaryBlue, fontSize: 11, height: 1.4)),
    );
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isMe
          ? [Flexible(child: bubble), const SizedBox(width: 8), avatar]
          : [avatar, const SizedBox(width: 8), Flexible(child: bubble)],
    );
  }

  Widget _buildControlBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Row(
                children: [
                  Icon(Icons.logout, color: Colors.red, size: 18),
                  SizedBox(width: 4),
                  Text('Leave', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _showChat = !_showChat),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: _showChat ? kPrimaryBlue : Colors.white,
                child: Icon(Icons.chat_bubble_outline, color: _showChat ? Colors.white : kPrimaryBlue),
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFF2F5F8),
              child: const Icon(Icons.volume_up_outlined, color: kTextGrey),
            ),
            GestureDetector(
              onTap: () => setState(() => _muted = !_muted),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFF2F5F8),
                child: Icon(_muted ? Icons.mic_off_outlined : Icons.mic_outlined, color: kTextGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
