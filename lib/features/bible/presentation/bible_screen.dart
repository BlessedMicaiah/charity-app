import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../data/scripture.dart';
import '../data/scripture_repository.dart';

final scriptureRepoProvider = Provider((ref) => ScriptureRepository());

final scripturesProvider = FutureProvider<List<Scripture>>((ref) async {
  final repo = ref.read(scriptureRepoProvider);
  return repo.getAllScriptures();
});

class BibleScreen extends ConsumerStatefulWidget {
  const BibleScreen({super.key});

  @override
  ConsumerState<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends ConsumerState<BibleScreen> {
  bool _isSyncing = false;

  Future<void> _sync() async {
    setState(() => _isSyncing = true);
    try {
      await ref.read(scriptureRepoProvider).syncScripture();
      ref.invalidate(scripturesProvider); // Refresh list
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scripturesAsync = ref.watch(scripturesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Offline Bible'),
        actions: [
          IconButton(
            icon: _isSyncing
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.download_rounded),
            onPressed: _isSyncing ? null : _sync,
            tooltip: "Download/Sync",
          ),
        ],
      ),
      body: scripturesAsync.when(
        data: (scriptures) {
          if (scriptures.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.offline_pin_outlined, size: 64, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  const Text('No Scriptures Cached'),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: _sync, child: const Text("Download Offline Data")),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scriptures.length,
            itemBuilder: (context, index) {
              final s = scriptures[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: NeumorphicContainer(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${s.book} ${s.chapter}:${s.verse}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      const SizedBox(height: 8),
                      Text(s.text, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
