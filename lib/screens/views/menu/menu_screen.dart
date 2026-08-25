import 'package:flutter/material.dart';
import 'package:kiteby/core/auth_service.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';
import 'package:kiteby/screens/views/profile/edit_profile_screen.dart';

class _MenuItem {
  final IconData icon;
  final String label;
  const _MenuItem(this.icon, this.label);
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const _account = [
    _MenuItem(Icons.person_outline, 'Edit profile'),
    _MenuItem(Icons.shield_outlined, 'security'),
    _MenuItem(Icons.notifications_none, 'Notifications'),
    _MenuItem(Icons.lock_outline, 'Privacy'),
  ];

  static const _support = [
    _MenuItem(Icons.credit_card_outlined, 'My Subscribtion'),
    _MenuItem(Icons.help_outline, 'Help & Support'),
    _MenuItem(Icons.info_outline, 'Terms and Policies'),
  ];

  static const _cache = [
    _MenuItem(Icons.delete_outline, 'Free up space'),
    _MenuItem(Icons.data_usage_outlined, 'Data Saver'),
  ];

  static const _actions = [
    _MenuItem(Icons.flag_outlined, 'Report a problem'),
    _MenuItem(Icons.group_add_outlined, 'Add account'),
    _MenuItem(Icons.logout, 'Log out'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Center(
              child: Icon(Icons.menu_book, size: 46, color: kPrimaryBlue.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 20),
            _sectionTitle('Account'),
            _sectionCard(context, _account),
            const SizedBox(height: 20),
            _sectionTitle('Support & About'),
            _sectionCard(context, _support),
            const SizedBox(height: 20),
            _sectionTitle('Cache & cellular'),
            _sectionCard(context, _cache),
            const SizedBox(height: 20),
            _sectionTitle('Actions'),
            _sectionCard(context, _actions),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final shouldLogOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel', style: TextStyle(color: kTextGrey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Log out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldLogOut != true) return;

    await AuthService.instance.signOut();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (route) => false,
    );
  }

  Widget _sectionCard(BuildContext context, List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFEAF1F8), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: items.map((item) {
          return InkWell(
            onTap: () {
              switch (item.label) {
                case 'Edit profile':
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                case 'Log out':
                  _confirmLogout(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(item.icon, color: kPrimaryBlue, size: 20),
                  const SizedBox(width: 14),
                  Text(item.label, style: const TextStyle(color: kPrimaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
