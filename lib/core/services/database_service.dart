import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/auth/data/user_preferences.dart';
import '../../features/bible/data/scripture.dart';

class DatabaseService {
  static late Isar isar;
  static SupabaseClient? supabase;

  static Future<void> init() async {
    // Supabase
    // Using placeholder values. Replace with real credentials.
    // For local development or mock, these won't work unless real values are provided.
    // The user requested "Real Supabase... connectivity", so I'll put placeholders
    // and a comment.
    const supabaseUrl = 'https://xyzcompany.supabase.co';
    const supabaseAnonKey = 'public-anon-key';

    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      supabase = Supabase.instance.client;
    } catch (e) {
      print('Supabase init failed: $e');
      // Continue without Supabase for UI testing
    }

    // Isar
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserPreferencesSchema, ScriptureSchema],
      directory: dir.path,
    );
  }
}
