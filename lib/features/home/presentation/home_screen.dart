import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neumorphic_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _aiController = TextEditingController();
  String? _aiResponse;
  bool _isLoading = false;

  void _submitAiQuery() async {
    if (_aiController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _aiResponse = null;
    });

    // Mock delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _aiResponse = "Scripture says: For God so loved the world... (John 3:16)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildDailyMannaCard(),
              const SizedBox(height: 24),
              _buildAiPromptBar(),
              if (_aiResponse != null) ...[
                const SizedBox(height: 16),
                _buildAiResponseCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
            Text(
              'Disciple',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        NeumorphicContainer(
          width: 40,
          height: 40,
          shape: BoxShape.circle,
          child: const Icon(Icons.notifications_outlined, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildDailyMannaCard() {
    return NeumorphicContainer(
      width: double.infinity,
      height: 200,
      borderRadius: 20,
      color: AppColors.background,
      child: Stack(
        children: [
          // Placeholder for blurred image background
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                    child: Icon(Icons.wb_sunny_rounded, size: 80, color: Colors.orange.withOpacity(0.2)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Daily Manna',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'The Lord is my shepherd; I shall not want.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Psalm 23:1',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiPromptBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ask the Evangelism Coach',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: NeumorphicContainer(
                height: 50,
                borderRadius: 25,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _aiController,
                  decoration: const InputDecoration(
                    hintText: 'How do I share the Gospel?',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (_) => _submitAiQuery(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            NeumorphicContainer(
              width: 50,
              height: 50,
              shape: BoxShape.circle, // Actually creating circle shape in NeumorphicContainer
              color: AppColors.primary,
              onTap: _submitAiQuery,
              child: _isLoading
                  ? const Center(child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  ))
                  : const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAiResponseCard() {
    return NeumorphicContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: AppColors.accent, size: 20),
              SizedBox(width: 8),
              Text('Biblical Answer', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _aiResponse ?? '',
            style: const TextStyle(height: 1.5, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
