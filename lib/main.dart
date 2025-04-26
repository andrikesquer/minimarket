import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme/app_theme.dart';
import 'package:pos2/presentation/providers/theme/theme_provider.dart';
import 'package:pos2/routes/routes.dart';
import 'data/data_sources/objectbox_database.dart';

late ObjectBoxDatabase objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  objectbox = await ObjectBoxDatabase.create();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final Routes _routes = Routes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MiniMarket',
      theme: AppTheme(isDarkMode: isDarkMode).getTheme(),
      routerConfig: _routes.router,
    );
  }
}
