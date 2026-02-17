import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../objectbox.g.dart'; // This file will be generated

class DatabaseService {
  static Store? store;
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
      if (kDebugMode) {
        print('Supabase init failed: $e');
      }
      // Continue without Supabase for UI testing
    }

    // ObjectBox
    if (!kIsWeb) {
      final docsDir = await getApplicationDocumentsDirectory();
      // Future-proofing: ObjectBox Store.open needs a directory path.
      store = await openStore(directory: p.join(docsDir.path, "objectbox"));
    }
  }
}
