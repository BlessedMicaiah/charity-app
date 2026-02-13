import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/theme/app_colors.dart';

class StealthLoginScreen extends ConsumerStatefulWidget {
  final VoidCallback onAuthenticated;

  const StealthLoginScreen({super.key, required this.onAuthenticated});

  @override
  ConsumerState<StealthLoginScreen> createState() => _StealthLoginScreenState();
}

class _StealthLoginScreenState extends ConsumerState<StealthLoginScreen> {
  String _pin = '';
  // Default PIN for MVP is '1234'
  final String _correctPin = '1234';

  void _onDigitPress(String digit) {
    setState(() {
      if (_pin.length < 4) {
        _pin += digit;
        if (_pin == _correctPin) {
          widget.onAuthenticated();
        } else if (_pin.length == 4) {
          // Wrong PIN logic
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Incorrect PIN')),
              );
              setState(() {
                _pin = '';
              });
            }
          });
        }
      }
    });
  }

  void _onDelete() {
    setState(() {
      if (_pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.lock_outline, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 24),
            Text(
              'Enter PIN',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length ? AppColors.primary : AppColors.shadowDark,
                  ),
                );
              }),
            ),
            const Spacer(),
            _buildKeypad(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 24),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 24),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 24),
        _buildRow(['', '0', 'del']),
      ],
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) {
        if (key.isEmpty) return const SizedBox(width: 80);
        if (key == 'del') {
            return GestureDetector(
              onTap: _onDelete,
              child: Container(
                width: 80,
                alignment: Alignment.center,
                child: const Icon(Icons.backspace_outlined)
              )
            );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NeumorphicContainer(
            width: 80,
            height: 80,
            shape: BoxShape.circle,
            onTap: () => _onDigitPress(key),
            child: Center(
              child: Text(
                key,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
