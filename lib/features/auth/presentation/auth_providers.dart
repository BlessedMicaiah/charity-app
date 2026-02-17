import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_preferences.dart';
import '../../../core/services/database_service.dart';

final userPreferencesProvider = FutureProvider<UserPreferences?>((ref) async {
  if (kIsWeb) {
    // ObjectBox is disabled on web. Return a default/in-memory instance.
    return UserPreferences()
      ..isStealthMode = false
      ..isLiteMode = false;
  }

  final store = DatabaseService.store;
  if (store == null) return null;

  final box = store.box<UserPreferences>();

  // Get the first user pref or create default
  // ObjectBox IDs start at 1 usually, but if we query all we can find the first.
  final prefs = box.getAll().firstOrNull;

  if (prefs == null) {
    final newPrefs = UserPreferences();
    box.put(newPrefs);
    return newPrefs;
  }
  return prefs;
});
