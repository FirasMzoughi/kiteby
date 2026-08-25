import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kiteby/core/supabase_config.dart';

/// Thrown when a signup succeeded but Supabase returned no session, which
/// happens whenever "Confirm email" is enabled for the project. Until the user
/// clicks the link in their inbox they are not authenticated, so any follow-up
/// write (profile details, genres) would be silently rejected by RLS.
class EmailConfirmationRequired implements Exception {
  const EmailConfirmationRequired();

  @override
  String toString() =>
      'Check your inbox to confirm your email, then log in to finish setting up your account.';
}

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  User? get currentUser => supabase.auth.currentUser;
  Session? get currentSession => supabase.auth.currentSession;
  bool get isLoggedIn => currentSession != null;

  Stream<AuthState> get onAuthStateChange => supabase.auth.onAuthStateChange;

  /// Creates the account. The `profiles` row itself is created by the
  /// `on_auth_user_created` database trigger, so this only fills in the extra
  /// details the trigger cannot know about.
  ///
  /// Throws [EmailConfirmationRequired] if the project requires email
  /// confirmation, since the caller cannot write profile data yet.
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    String? role,
    int? age,
    String? country,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        if (role != null) 'role': role,
      },
    );

    if (response.session == null) {
      throw const EmailConfirmationRequired();
    }

    if (age != null || country != null) {
      await updateProfile(age: age, country: country);
    }

    return response;
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() => supabase.auth.signOut();

  Future<void> resetPassword(String email) {
    return supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> updateProfile({
    String? fullName,
    String? role,
    int? age,
    String? country,
    String? bio,
    String? avatarUrl,
  }) async {
    final userId = currentUser?.id;
    if (userId == null) return;

    final updates = <String, dynamic>{
      if (fullName != null) 'full_name': fullName,
      if (role != null) 'role': role,
      if (age != null) 'age': age,
      if (country != null) 'country': country,
      if (bio != null) 'bio': bio,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    };
    if (updates.isEmpty) return;

    await supabase.from('profiles').update(updates).eq('id', userId);
  }

  Future<void> updateNotificationPreferences({
    required bool dailyReports,
    required bool weeklySummary,
  }) async {
    final userId = currentUser?.id;
    if (userId == null) return;
    await supabase.from('profiles').update({
      'daily_reports': dailyReports,
      'weekly_summary': weeklySummary,
    }).eq('id', userId);
  }

  Future<void> setGenres(List<String> genreNames) async {
    final userId = currentUser?.id;
    if (userId == null) return;

    await supabase.from('profile_genres').delete().eq('profile_id', userId);
    if (genreNames.isEmpty) return;

    final genres = await supabase
        .from('genres')
        .select('id')
        .inFilter('name', genreNames);

    final rows = (genres as List)
        .map((g) => {'profile_id': userId, 'genre_id': g['id']})
        .toList();
    if (rows.isNotEmpty) {
      await supabase.from('profile_genres').insert(rows);
    }
  }

  Future<Map<String, dynamic>?> fetchMyProfile() async {
    final userId = currentUser?.id;
    if (userId == null) return null;
    return supabase.from('profiles').select().eq('id', userId).maybeSingle();
  }
}
