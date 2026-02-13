import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/bible/presentation/bible_screen.dart';
import '../../features/missions/presentation/missions_screen.dart';
import '../../features/community/presentation/community_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/auth/presentation/stealth_login_screen.dart';
import 'scaffold_with_navbar.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // We can watch auth state here if needed for redirection logic

  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/stealth',
        builder: (context, state) => StealthLoginScreen(
          onAuthenticated: () {
            context.go('/home');
          },
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/bible', builder: (context, state) => const BibleScreen()),
          GoRoute(path: '/missions', builder: (context, state) => const MissionsScreen()),
          GoRoute(path: '/community', builder: (context, state) => const CommunityScreen()),
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        ],
      ),
    ],
  );
});
