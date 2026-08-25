import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase credentials, loaded from the gitignored `.env` file at startup.
///
/// See `.env.example` for the expected keys. `SUPABASE_KEY` must be the
/// publishable key (`sb_publishable_...`) or the legacy anon key -- never the
/// service_role key, which bypasses Row Level Security.
class SupabaseConfig {
  static String get url {
    final value = dotenv.env['SUPABASE_URL'];
    if (value == null || value.isEmpty) {
      throw StateError(
        'SUPABASE_URL is missing. Copy .env.example to .env and fill it in.',
      );
    }
    return value;
  }

  static String get publishableKey {
    final value = dotenv.env['SUPABASE_KEY'];
    if (value == null || value.isEmpty) {
      throw StateError(
        'SUPABASE_KEY is missing. Copy .env.example to .env and fill it in.',
      );
    }
    return value;
  }

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    await Supabase.initialize(
      url: url,
      // `sb_publishable_...` keys use publishableKey; the older `eyJ...` anon
      // keys are accepted here too.
      publishableKey: publishableKey,
    );
  }
}

SupabaseClient get supabase => Supabase.instance.client;
