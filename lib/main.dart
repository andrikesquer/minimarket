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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final isDarkMode = ref.watch(darkModeProvider);

    return isDarkMode.when(
      loading:
          () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          ),
      error:
          (e, _) => MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error cargando tema: $e')),
            ),
          ),
      data:
          (isDarkMode) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'MiniMarket',
            theme: AppTheme(isDarkMode: isDarkMode).getTheme(),
            routerConfig: router,
          ),
    );
  }
}
