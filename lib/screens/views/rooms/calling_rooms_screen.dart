import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';
import 'package:kiteby/screens/views/rooms/chat_screen.dart';
import 'package:kiteby/screens/views/rooms/live_room_screen.dart';

class CallingRoomsScreen extends StatelessWidget {
  const CallingRoomsScreen({super.key});

  void _openJoinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _JoinRoomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF3F8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.chevron_left, color: kPrimaryBlue),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text('Calling Rooms',
                            style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: kFieldBorder)),
                    child: const Icon(Icons.add, color: kPrimaryBlue),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _openJoinSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text('See more', style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                  const SizedBox(width: 10),
                  ...List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => _openJoinSheet(context),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: index == 1 ? const Color(0xFFE9C08A) : kFieldBorder,
                          child: index == 1
                              ? const Icon(Icons.menu_book, color: kPrimaryBlue, size: 18)
                              : null,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: const Text('Messages', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 8,
                itemBuilder: (context, index) {
                  final unread = index % 2 == 1;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ChatScreen(name: 'Sami Sami')),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: unread ? const Color(0xFFDCEBFA) : const Color(0xFFF2F5F8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 22, backgroundColor: kFieldBorder, child: Icon(Icons.person, color: kPrimaryBlue)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Ahmed', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue, fontSize: 14)),
                                const Text('Hello, I really like your book about...',
                                    maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: kTextGrey, fontSize: 12)),
                                const Text('2 mins ago', style: TextStyle(color: kTextGrey, fontSize: 11)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('20', style: TextStyle(color: kTextGrey, fontSize: 12)),
                              const SizedBox(height: 4),
                              Icon(Icons.chat_bubble, size: 18, color: unread ? kPrimaryBlue : kTextGrey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JoinRoomSheet extends StatelessWidget {
  const _JoinRoomSheet();

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
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 160,
              width: double.infinity,
              color: const Color(0xFFE9C08A),
              child: const Center(child: Icon(Icons.menu_book, size: 40, color: kPrimaryBlue)),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Book Online Room', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LiveRoomScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kLightBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Join Now', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
