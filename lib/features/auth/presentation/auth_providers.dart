import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../data/user_preferences.dart';
import '../../../core/services/database_service.dart';

final userPreferencesProvider = FutureProvider<UserPreferences?>((ref) async {
  if (kIsWeb) {
    // Isar is disabled on web. Return a default/in-memory instance.
    return UserPreferences()
      ..isStealthMode = false
      ..isLiteMode = false;
  }

  final isar = DatabaseService.isar;
  if (isar == null) return null;

  // Get the first user pref or create default
  final prefs = await isar.userPreferences.where().findFirst();
  if (prefs == null) {
    final newPrefs = UserPreferences();
    await isar.writeTxn(() async {
      await isar.userPreferences.put(newPrefs);
    });
    return newPrefs;
  }
  return prefs;
});
