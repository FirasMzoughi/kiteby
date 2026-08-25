import 'package:flutter/material.dart';
import 'package:kiteby/core/supabase_config.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';
import 'package:kiteby/screens/views/home/home_screen.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  Future<void> _selectRole(BuildContext context, String role) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      try {
        await supabase.from('profiles').update({'role': role}).eq('id', userId);
      } catch (_) {
        // Non-fatal: fall through to navigation even if the update fails.
      }
    }
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -70,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: kPrimaryGradient,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: -60,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: kPrimaryGradient,
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [kLightBlue.withValues(alpha: 0.8), kPrimaryBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: -70,
            child: Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: kPrimaryGradient,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.lightbulb_outline,
                size: 50,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RoleOption(
                    icon: Icons.person_outline,
                    label: 'As auther',
                    circleGradient: const LinearGradient(
                      colors: [Color(0xFF14213D), Color(0xFF1F3A5F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    buttonColor: const Color(0xFF6B87B0),
                    onTap: () => _selectRole(context, 'author'),
                  ),
                  const SizedBox(width: 28),
                  _RoleOption(
                    icon: Icons.menu_book_rounded,
                    label: 'As reader',
                    circleGradient: const LinearGradient(
                      colors: [Color(0xFF2E7BF0), Color(0xFF1E5FD1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    buttonColor: const Color(0xFF6FA9F5),
                    onTap: () => _selectRole(context, 'reader'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Gradient circleGradient;
  final Color buttonColor;
  final VoidCallback onTap;

  const _RoleOption({
    required this.icon,
    required this.label,
    required this.circleGradient,
    required this.buttonColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: circleGradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 44),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
