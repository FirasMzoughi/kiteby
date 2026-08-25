import 'package:supabase_flutter/supabase_flutter.dart';

/// Paste your Supabase project credentials here.
/// Find them in your Supabase dashboard under Project Settings > API.
class SupabaseConfig {
  static const String url = 'https://YOUR_PROJECT_REF.supabase.co';
  static const String anonKey = 'YOUR_SUPABASE_ANON_KEY';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }
}

SupabaseClient get supabase => Supabase.instance.client;
