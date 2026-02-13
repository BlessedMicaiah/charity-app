import 'package:isar/isar.dart';
import '../../../core/services/database_service.dart';
import 'scripture.dart';

class ScriptureRepository {
  final Isar _isar = DatabaseService.isar;

  // Simulate fetching from Supabase and saving to Isar
  Future<void> syncScripture() async {
    // Mock data from "Backend"
    final mockData = [
      Scripture()
        ..book = 'John'
        ..chapter = 3
        ..verse = 16
        ..text = 'For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.',
      Scripture()
        ..book = 'Genesis'
        ..chapter = 1
        ..verse = 1
        ..text = 'In the beginning, God created the heavens and the earth.',
      Scripture()
        ..book = 'Psalm'
        ..chapter = 23
        ..verse = 1
        ..text = 'The Lord is my shepherd; I shall not want.',
      Scripture()
        ..book = 'Philippians'
        ..chapter = 4
        ..verse = 13
        ..text = 'I can do all things through him who strengthens me.',
    ];

    await _isar.writeTxn(() async {
      await _isar.scriptures.clear(); // Clear old for demo
      await _isar.scriptures.putAll(mockData);
    });
  }

  Future<List<Scripture>> getAllScriptures() async {
    return _isar.scriptures.where().findAll();
  }
}
