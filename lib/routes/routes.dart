import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/presentation/providers/session_provider.dart';
import 'package:pos2/presentation/screens/screens.dart';
import 'package:pos2/data/models/session_model.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final sessionState = ref.watch(sessionProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshNotifier(ref),
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';

      if (sessionState.status == Status.unauthenticated && !isLoggingIn) {
        return '/login';
      }

      if (sessionState.status == Status.authenticated && isLoggingIn) {
        return '/${sessionState.email}';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: '/products', builder: (context, state) => const Products()),
      GoRoute(
        path: '/sales',
        builder: (context, state) => const SalesScreen(),
        routes: [
          GoRoute(path: 'sell', builder: (context, state) => SellScreen()),
          GoRoute(path: 'history', builder: (context, state) => SalesHistory()),
        ],
      ),
      GoRoute(path: '/cart', builder: (context, state) => const Cart()),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsScreen(),
        routes: [
          GoRoute(
            path: 'sales',
            builder: (context, state) => SalesReportScreen(),
          ),
        ],
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return Home(email: email);
        },
      ),
    ],
  );
});

// Change notifier
class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Ref ref) {
    ref.listen<SessionState>(sessionProvider, (_, __) => notifyListeners());
  }
}
