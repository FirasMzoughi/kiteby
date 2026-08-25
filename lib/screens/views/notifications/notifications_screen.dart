import 'package:flutter/material.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class _NotificationItem {
  final String name;
  final String action;
  final String target;
  final bool isFollow;
  const _NotificationItem(this.name, this.action, this.target, {this.isFollow = false});
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const _items = [
    _NotificationItem('Sami Sami', 'liked', '"tow the moon"'),
    _NotificationItem('Sayda Sayda', 'liked', '"Autumn in my heart"', isFollow: true),
    _NotificationItem('Sami Sami', 'liked', '"tow the moon"'),
    _NotificationItem('Sayda Sayda', 'liked', '"Autumn in my heart"', isFollow: true),
    _NotificationItem('Sami Sami', 'liked', '"tow the moon"'),
    _NotificationItem('Sayda Sayda', 'liked', '"Autumn in my heart"', isFollow: true),
    _NotificationItem('Sami Sami', 'liked', '"tow the moon"'),
  ];

  void _openSettingsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _NotificationSettingsSheet(),
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
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: 'Notifications ', style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold, fontSize: 17)),
                          TextSpan(text: '(04)', style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold, fontSize: 17)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _openSettingsSheet,
                      child: const Icon(Icons.settings_outlined, color: kPrimaryBlue),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final highlighted = index.isEven;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: highlighted ? Colors.white : const Color(0xFFDCEBFA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: item.isFollow ? const Color(0xFF8B3A2B) : kFieldBorder,
                          child: const Icon(Icons.person, color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: kPrimaryBlue, fontSize: 13),
                              children: [
                                TextSpan(text: '${item.name} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: '${item.action} '),
                                TextSpan(text: item.target, style: const TextStyle(color: Color(0xFF2E7BF0))),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        item.isFollow
                            ? OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: kPrimaryBlue),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  minimumSize: Size.zero,
                                ),
                                child: const Text('Follow', style: TextStyle(color: kPrimaryBlue, fontSize: 11)),
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: const Color(0xFFF4EFE3), borderRadius: BorderRadius.circular(6)),
                                child: const Icon(Icons.menu_book, color: kPrimaryBlue, size: 18),
                              ),
                      ],
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

class _NotificationSettingsSheet extends StatefulWidget {
  const _NotificationSettingsSheet();

  @override
  State<_NotificationSettingsSheet> createState() => _NotificationSettingsSheetState();
}

class _NotificationSettingsSheetState extends State<_NotificationSettingsSheet> {
  bool _collections = true;
  bool _commentLikes = false;
  bool _followers = false;
  bool _likes = true;

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
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kFieldBorder)),
              child: const Icon(Icons.close, size: 18, color: kPrimaryBlue),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Activity Feed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
          const SizedBox(height: 16),
          _switchRow('Collections', _collections, (v) => setState(() => _collections = v)),
          _switchRow('Comment Likes', _commentLikes, (v) => setState(() => _commentLikes = v)),
          _switchRow('Followers', _followers, (v) => setState(() => _followers = v)),
          _switchRow('Likes', _likes, (v) => setState(() => _likes = v)),
        ],
      ),
    );
  }

  Widget _switchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: value ? const Color(0xFFDCEBFA) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(color: value ? kPrimaryBlue : kTextGrey, fontWeight: FontWeight.w600, fontSize: 14)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: kPrimaryBlue,
            inactiveTrackColor: kFieldBorder,
          ),
        ],
      ),
    );
  }
}
