import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/neumorphic_container.dart';
import '../theme/app_colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/home')) {
      currentIndex = 0;
    } else if (location.startsWith('/bible')) {
      currentIndex = 1;
    } else if (location.startsWith('/missions')) {
      currentIndex = 2;
    } else if (location.startsWith('/community')) {
      currentIndex = 3;
    } else if (location.startsWith('/profile')) {
      currentIndex = 4;
    }

    return NeumorphicContainer(
      height: 80,
      borderRadius: 0,
      color: AppColors.background,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(context, 0, Icons.home_rounded, 'Home', currentIndex),
            _buildTabItem(context, 1, Icons.menu_book_rounded, 'Bible', currentIndex),
            _buildTabItem(context, 2, Icons.volunteer_activism_rounded, 'Missions', currentIndex), // "Give" icon in design but "Missions" function
            _buildTabItem(context, 3, Icons.people_rounded, 'Community', currentIndex),
            _buildTabItem(context, 4, Icons.person_rounded, 'Profile', currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index, IconData icon, String label, int currentIndex) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0: context.go('/home'); break;
          case 1: context.go('/bible'); break;
          case 2: context.go('/missions'); break;
          case 3: context.go('/community'); break;
          case 4: context.go('/profile'); break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
