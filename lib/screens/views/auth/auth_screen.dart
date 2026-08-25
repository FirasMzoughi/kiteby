import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kiteby/core/auth_service.dart';
import 'package:kiteby/screens/views/auth/welcome_final_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;

const Color kPrimaryBlue = Color(0xFF2D5F9A);
const Color kLightBlue = Color(0xFF6CC8E8);
const Color kTextGrey = Color(0xFF9AA5B1);
const Color kFieldBorder = Color(0xFFD7E1EA);

const LinearGradient kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF2D5F9A), Color(0xFF6CC8E8)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  int _signupStep = 0;
  bool _isSubmitting = false;

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _dailyReports = false;
  bool _weeklySummary = true;
  final Set<String> _selectedGenres = {};

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _usernameController.dispose();
    _ageController.dispose();
    _countryController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _switchTab(bool login) {
    setState(() {
      _isLogin = login;
      _signupStep = 0;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  Future<void> _handleLogin() async {
    if (_loginEmailController.text.trim().isEmpty || _loginPasswordController.text.isEmpty) {
      _showError('Please enter your email and password.');
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await AuthService.instance.signIn(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeFinalScreen()),
      );
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _nextStep() async {
    if (_signupStep == 0) {
      if (_usernameController.text.trim().isEmpty) {
        _showError('Please enter a username.');
        return;
      }
      setState(() => _signupStep++);
      return;
    }

    if (_signupStep == 1) {
      if (_signupEmailController.text.trim().isEmpty ||
          _signupPasswordController.text.isEmpty) {
        _showError('Please fill in your email and password.');
        return;
      }
      if (_signupPasswordController.text != _confirmPasswordController.text) {
        _showError('Passwords do not match.');
        return;
      }
      setState(() => _isSubmitting = true);
      try {
        await AuthService.instance.signUp(
          email: _signupEmailController.text.trim(),
          password: _signupPasswordController.text,
          username: _usernameController.text.trim(),
          age: int.tryParse(_ageController.text.trim()),
          country: _countryController.text.trim().isEmpty ? null : _countryController.text.trim(),
        );
        await AuthService.instance.updateNotificationPreferences(
          dailyReports: _dailyReports,
          weeklySummary: _weeklySummary,
        );
        if (!mounted) return;
        setState(() => _signupStep++);
      } on EmailConfirmationRequired catch (e) {
        // Account exists but there is no session yet, so the remaining steps
        // cannot write anything. Send them back to the login tab.
        _showError(e.toString());
        if (mounted) _switchTab(true);
      } on AuthException catch (e) {
        _showError(e.message);
      } catch (e) {
        _showError('Something went wrong. Please try again.');
      } finally {
        if (mounted) setState(() => _isSubmitting = false);
      }
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await AuthService.instance.setGenres(_selectedGenres.toList());
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeFinalScreen()),
      );
    } catch (e) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabs(),
              const SizedBox(height: 28),
              if (_isLogin) _buildLoginForm() else _buildSignupStep(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _tabItem('Log in', _isLogin, () => _switchTab(true)),
        const SizedBox(width: 28),
        _tabItem('Sign up', !_isLogin, () => _switchTab(false)),
      ],
    );
  }

  Widget _tabItem(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: active ? kPrimaryBlue : kTextGrey,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            width: label == 'Log in' ? 56 : 64,
            color: active ? kPrimaryBlue : Colors.transparent,
          ),
        ],
      ),
    );
  }

  // ---------------- LOGIN ----------------

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _fieldLabel('Your Email'),
        _textField(controller: _loginEmailController, hint: 'Enter your email'),
        const SizedBox(height: 18),
        _fieldLabel('Password'),
        _textField(
          controller: _loginPasswordController,
          hint: 'Enter your password',
          obscure: _obscurePassword,
          suffix: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: kTextGrey,
              size: 20,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: _isSubmitting
                ? null
                : () async {
                    if (_loginEmailController.text.trim().isEmpty) {
                      _showError('Enter your email first, then tap Forgot password.');
                      return;
                    }
                    try {
                      await AuthService.instance.resetPassword(_loginEmailController.text.trim());
                      if (!mounted) return;
                      _showError('Password reset email sent.');
                    } catch (_) {
                      _showError('Could not send reset email.');
                    }
                  },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Text(
              'Forgot password?',
              style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _gradientButton(_isSubmitting ? 'Please wait...' : 'Continue', _isSubmitting ? null : _handleLogin),
        const SizedBox(height: 24),
        _orDivider(),
        const SizedBox(height: 20),
        _socialButton('Login with Google'),
        const SizedBox(height: 14),
        _socialButton('Login with Facebook'),
        const SizedBox(height: 14),
        _socialButton('Login with Apple'),
        const SizedBox(height: 24),
        Center(
          child: RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: const TextStyle(color: kTextGrey, fontSize: 14),
              children: [
                TextSpan(
                  text: 'Sign up',
                  style: const TextStyle(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => _switchTab(false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- SIGNUP ----------------

  Widget _buildSignupStep() {
    switch (_signupStep) {
      case 0:
        return _buildSignupStepOne();
      case 1:
        return _buildSignupStepTwo();
      default:
        return _buildSignupStepThree();
    }
  }

  Widget _buildSignupStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Create account',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kPrimaryBlue,
          ),
        ),
        const SizedBox(height: 24),
        _fieldLabel('Username'),
        _textField(controller: _usernameController, hint: 'Your username'),
        const SizedBox(height: 18),
        _fieldLabel('Age'),
        _textField(
          controller: _ageController,
          hint: 'Select your age',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 18),
        _fieldLabel('Country'),
        _textField(controller: _countryController, hint: 'Select your country'),
        const SizedBox(height: 32),
        _gradientButton(_isSubmitting ? 'Please wait...' : 'Continue', _isSubmitting ? null : _nextStep),
        const SizedBox(height: 20),
        _stepDots(0),
        const SizedBox(height: 16),
        _loginLink(),
      ],
    );
  }

  Widget _buildSignupStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Create account',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kPrimaryBlue,
          ),
        ),
        const SizedBox(height: 24),
        _fieldLabel('Email'),
        _textField(
          controller: _signupEmailController,
          hint: 'example@gmail.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 18),
        _fieldLabel('Create a password'),
        _textField(
          controller: _signupPasswordController,
          hint: 'Must be 8 characters',
          obscure: _obscurePassword,
          suffix: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: kTextGrey,
              size: 20,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        const SizedBox(height: 18),
        _fieldLabel('Confirm password'),
        _textField(
          controller: _confirmPasswordController,
          hint: 'Repeat password',
          obscure: _obscureConfirm,
          suffix: IconButton(
            icon: Icon(
              _obscureConfirm
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: kTextGrey,
              size: 20,
            ),
            onPressed: () =>
                setState(() => _obscureConfirm = !_obscureConfirm),
          ),
        ),
        const SizedBox(height: 20),
        _switchRow(
          'Daily reports',
          'Get a daily avtivity report via email.',
          _dailyReports,
          (v) => setState(() => _dailyReports = v),
        ),
        const SizedBox(height: 14),
        _switchRow(
          'Weekly summary',
          'Get a weekly avtivity report via email.',
          _weeklySummary,
          (v) => setState(() => _weeklySummary = v),
        ),
        const SizedBox(height: 24),
        _gradientButton(_isSubmitting ? 'Please wait...' : 'Continue', _isSubmitting ? null : _nextStep),
        const SizedBox(height: 20),
        _stepDots(1),
        const SizedBox(height: 16),
        _loginLink(),
      ],
    );
  }

  Widget _buildSignupStepThree() {
    const genres = [
      'Literary Fiction',
      'Historical Fiction',
      'Romance',
      'Fantasy',
      'Science Fiction (Sci-Fi)',
      "Children's Fiction",
      'Horror',
      'Adventure',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select your fiction',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: kPrimaryBlue,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: genres.map((g) => _genreChip(g)).toList(),
        ),
        const SizedBox(height: 32),
        _gradientButton(_isSubmitting ? 'Please wait...' : 'Continue', _isSubmitting ? null : _nextStep),
        const SizedBox(height: 20),
        _stepDots(2),
        const SizedBox(height: 40),
        _loginLink(),
      ],
    );
  }

  Widget _genreChip(String label) {
    final bool selected = _selectedGenres.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selected) {
            _selectedGenres.remove(label);
          } else {
            _selectedGenres.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: selected ? kPrimaryGradient : null,
          color: selected ? null : Colors.white,
          border: Border.all(color: selected ? Colors.transparent : kFieldBorder),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : kTextGrey,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // ---------------- SHARED WIDGETS ----------------

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: kPrimaryBlue,
        ),
      ),
    );
  }

  Widget _textField({
    TextEditingController? controller,
    required String hint,
    bool obscure = false,
    Widget? suffix,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kFieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: kPrimaryBlue, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: kTextGrey, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  Widget _gradientButton(String label, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: kPrimaryGradient,
          borderRadius: BorderRadius.circular(27),
          boxShadow: [
            BoxShadow(
              color: kLightBlue.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(27),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _orDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: kFieldBorder)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Or', style: TextStyle(color: kTextGrey)),
        ),
        Expanded(child: Divider(color: kFieldBorder)),
      ],
    );
  }

  Widget _socialButton(String label) {
    IconData icon;
    Color color;
    if (label.contains('Google')) {
      icon = Icons.g_mobiledata;
      color = const Color(0xFFEA4335);
    } else if (label.contains('Facebook')) {
      icon = Icons.facebook;
      color = const Color(0xFF1877F2);
    } else {
      icon = Icons.apple;
      color = Colors.black;
    }
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: kFieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: kPrimaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _switchRow(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: kPrimaryBlue,
          inactiveTrackColor: kFieldBorder,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: kTextGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _stepDots(int activeIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == activeIndex ? kPrimaryBlue : kFieldBorder,
          ),
        );
      }),
    );
  }

  Widget _loginLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Already have an account? ',
          style: const TextStyle(color: kTextGrey, fontSize: 14),
          children: [
            TextSpan(
              text: 'Log in',
              style: const TextStyle(
                color: kPrimaryBlue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => _switchTab(true),
            ),
          ],
        ),
      ),
    );
  }
}
