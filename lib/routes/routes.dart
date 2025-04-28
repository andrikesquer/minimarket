import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/presentation/screens/screens.dart';

class Routes {
  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/products',
        builder: (BuildContext context, GoRouterState state) {
          return const Products();
        },
      ),
      GoRoute(
        path: '/sales',
        builder: (BuildContext context, GoRouterState state) {
          return const SalesScreen();
        },
        routes: [
          GoRoute(
            path: 'sell',
            builder: (context, state) {
              return SellScreen();
            },
          ),
          GoRoute(
            path: 'history',
            builder: (context, state) {
              return SalesHistory();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/cart',
        builder: (BuildContext context, GoRouterState state) {
          return const Cart();
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        path: '/reports',
        builder: (BuildContext context, GoRouterState state) {
          return const ReportsScreen();
        },
        routes: [
          GoRoute(
            path: 'sales',
            builder: (context, state) {
              return SalesReportScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/:email',
        builder: (BuildContext context, GoRouterState state) {
          return Home(email: state.pathParameters['email']);
        },
      ),
    ],
  );
}
