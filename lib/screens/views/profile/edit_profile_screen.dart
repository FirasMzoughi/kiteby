import 'package:flutter/material.dart';
import 'package:kiteby/core/auth_service.dart';
import 'package:kiteby/screens/views/auth/auth_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await AuthService.instance.fetchMyProfile();
      if (!mounted) return;
      setState(() {
        _nameController.text =
            (profile?['full_name'] as String?) ?? (profile?['username'] as String? ?? '');
        _emailController.text = AuthService.instance.currentUser?.email ?? '';
        _countryController.text = (profile?['country'] as String?) ?? '';
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showMessage('Could not load your profile.', isError: true);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : kPrimaryBlue,
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await AuthService.instance.updateProfile(
        fullName: _nameController.text.trim(),
        country: _countryController.text.trim(),
      );
      if (!mounted) return;
      _showMessage('Profile updated.');
      Navigator.of(context).pop();
    } catch (_) {
      _showMessage('Could not save your changes.', isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: kPrimaryBlue))
            : ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFEAF1F8)),
                        child: const Icon(Icons.chevron_left, color: kPrimaryBlue),
                      ),
                    ),
                  ],
                ),
                const Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryBlue, width: 2),
                  color: kFieldBorder,
                ),
                child: const Icon(Icons.person, color: kPrimaryBlue, size: 44),
              ),
            ),
            const SizedBox(height: 28),
            _fieldLabel('Name'),
            _textField(_nameController),
            const SizedBox(height: 18),
            _fieldLabel('Email'),
            // Changing an account email needs a re-auth + confirmation flow, so
            // it is shown read-only here.
            _textField(_emailController, enabled: false),
            const SizedBox(height: 18),
            _fieldLabel('Country/Region'),
            _textField(_countryController),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kFieldBorder),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: kTextGrey)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      _isSaving ? 'Saving...' : 'Save changes',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kPrimaryBlue)),
    );
  }

  Widget _textField(
    TextEditingController controller, {
    bool obscure = false,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kFieldBorder),
        borderRadius: BorderRadius.circular(12),
        color: enabled ? null : const Color(0xFFF5F7FA),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        enabled: enabled,
        style: TextStyle(color: enabled ? kPrimaryBlue : kTextGrey, fontSize: 14),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
