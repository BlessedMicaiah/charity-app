import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../data/user_preferences.dart';
import '../../../core/services/database_service.dart';

final userPreferencesProvider = FutureProvider<UserPreferences?>((ref) async {
  final isar = DatabaseService.isar;
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
