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
      ),
      GoRoute(
        path: '/cart',
        builder: (BuildContext context, GoRouterState state) {
          return const Cart();
        },
      ),
      GoRoute(
        path: '/configuration',
        builder: (BuildContext context, GoRouterState state) {
          return const ConfigurationScreen();
        },
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
