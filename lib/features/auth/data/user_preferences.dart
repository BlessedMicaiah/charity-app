import 'package:isar/isar.dart';

part 'user_preferences.g.dart';

@collection
class UserPreferences {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? userId; // Supabase User ID

  bool isStealthMode = false;

  bool isLiteMode = false;

  String? pinCode;
}
