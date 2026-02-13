import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/database_service.dart';

class AuthRepository {
  Future<void> signIn(String email, String password) async {
    final supabase = DatabaseService.supabase;
    if (supabase == null) {
      throw Exception('Supabase client is not initialized (Offline Mode)');
    }
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    final supabase = DatabaseService.supabase;
    if (supabase == null) {
      throw Exception('Supabase client is not initialized (Offline Mode)');
    }
    await supabase.auth.signUp(email: email, password: password);
  }

  User? getCurrentUser() {
    return DatabaseService.supabase?.auth.currentUser;
  }
}
