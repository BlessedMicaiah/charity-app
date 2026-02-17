import 'package:objectbox/objectbox.dart';

@Entity()
class UserPreferences {
  @Id()
  int id = 0;

  @Index()
  @Unique()
  String? userId; // Supabase User ID

  bool isStealthMode = false;

  bool isLiteMode = false;

  String? pinCode;
}
