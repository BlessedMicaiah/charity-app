import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../../../core/services/database_service.dart';
import 'scripture.dart';

class ScriptureRepository {
  Isar? get _isar => DatabaseService.isar;

  // Mock data from "Backend"
  final _mockData = [
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

  // Simulate fetching from Supabase and saving to Isar
  Future<void> syncScripture() async {
    if (kIsWeb) {
      // On Web, we use "Supabase" directly (mocked here), so "sync" is a no-op
      // or just a refresh signal. Since we don't persist locally on web (per instructions),
      // we do nothing.
      return;
    }

    // Mobile/Desktop Logic: Save to Isar
    final isar = _isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.scriptures.clear(); // Clear old for demo
        await isar.scriptures.putAll(_mockData);
      });
    }
  }

  Future<List<Scripture>> getAllScriptures() async {
    if (kIsWeb) {
      // Return direct "Supabase" data
      return _mockData;
    }

    // Mobile/Desktop: Return from local DB
    final isar = _isar;
    if (isar == null) return [];

    return isar.scriptures.where().findAll();
  }
}
