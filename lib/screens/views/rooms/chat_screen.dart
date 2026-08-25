import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class _ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  final bool hasImage;
  const _ChatMessage(this.text, this.time, {this.isMe = false, this.hasImage = false});
}

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({super.key, required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  static const _vacationText =
      'Hello guys, we have discussed about post-corona vacation plan and our decision is to go to Bali. We will have a very big party after this corona ends! These are some images about our destination';

  static const _messages = [
    _ChatMessage(_vacationText, '16:00', hasImage: true),
    _ChatMessage("That's very nice place! you guys made a very good decision. Can't wait to go on vacation!", '16:04', isMe: true),
    _ChatMessage(_vacationText, '16:00', hasImage: true),
  ];

  @override
  void dispose() {
    _controller.dispose();
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
                    Expanded(
                      child: Text(widget.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 16)),
                    ),
                    _circleIcon(Icons.call_outlined),
                    const SizedBox(width: 8),
                    _circleIcon(Icons.videocam_outlined),
                    const SizedBox(width: 8),
                    _circleIcon(Icons.info_outline),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  ..._messages.map(_buildMessage),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      SizedBox(
                        width: 26,
                        height: 26,
                        child: CircleAvatar(radius: 13, backgroundColor: kFieldBorder),
                      ),
                      SizedBox(width: 8),
                      Text('Sami is typing', style: TextStyle(color: kPrimaryBlue, fontSize: 12, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ],
              ),
            ),
            _buildComposer(),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kFieldBorder)),
      child: Icon(icon, size: 16, color: kPrimaryBlue),
    );
  }

  Widget _buildMessage(_ChatMessage message) {
    final align = message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = message.isMe ? const Color(0xFFDCEBFA) : const Color(0xFFF2F5F8);
    final row = message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    final avatar = const CircleAvatar(radius: 14, backgroundColor: kFieldBorder, child: Icon(Icons.person, size: 14, color: kPrimaryBlue));

    final bubble = Column(
      crossAxisAlignment: align,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 240),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(14)),
          child: Column(
            crossAxisAlignment: align,
            children: [
              Text(message.text, style: const TextStyle(color: kPrimaryBlue, fontSize: 13, height: 1.4)),
              const SizedBox(height: 6),
              Text(message.time, style: const TextStyle(color: kTextGrey, fontSize: 10)),
            ],
          ),
        ),
        if (message.hasImage)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 130,
                height: 90,
                color: const Color(0xFF3C6E4B),
                child: const Icon(Icons.landscape, color: Colors.white54),
              ),
            ),
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: row,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: message.isMe
            ? [Flexible(child: bubble), const SizedBox(width: 8), avatar]
            : [avatar, const SizedBox(width: 8), Flexible(child: bubble)],
      ),
    );
  }

  Widget _buildComposer() {
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
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: kPrimaryBlue, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type something',
                  hintStyle: TextStyle(color: kTextGrey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.image_outlined, color: kPrimaryBlue),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => setState(() => _controller.clear()),
              child: const Icon(Icons.send, color: kPrimaryBlue),
            ),
          ],
        ),
      ),
    );
  }
}
