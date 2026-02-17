import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';
import '../../../core/services/database_service.dart';
import 'scripture.dart';

class ScriptureRepository {
  Store? get _store => DatabaseService.store;

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

  // Simulate fetching from Supabase and saving to ObjectBox
  Future<void> syncScripture() async {
    if (kIsWeb) {
      // On Web, we use "Supabase" directly (mocked here), so "sync" is a no-op
      // or just a refresh signal. Since we don't persist locally on web (per instructions),
      // we do nothing.
      return;
    }

    // Mobile/Desktop Logic: Save to ObjectBox
    final store = _store;
    if (store != null) {
      final box = store.box<Scripture>();

      // ObjectBox writes are synchronous by default unless runInTransaction is used,
      // but putting many items is fast.
      // To mimic the previous logic: clear and put all.

      box.removeAll();
      box.putMany(_mockData);
    }
  }

  Future<List<Scripture>> getAllScriptures() async {
    if (kIsWeb) {
      // Return direct "Supabase" data
      return _mockData;
    }

    // Mobile/Desktop: Return from local DB
    final store = _store;
    if (store == null) return [];

    return store.box<Scripture>().getAll();
  }
}
