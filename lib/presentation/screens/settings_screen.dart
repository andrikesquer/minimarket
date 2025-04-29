import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/presentation/providers/theme/theme_provider.dart';
import 'package:pos2/presentation/providers/session_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/:email');
            },
          ),
          title: Text(
            'Ajustes',
            style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                context.go('/:email');
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                IconButton(
                  onPressed: () {
                    ref.read(darkModeProvider.notifier).toggleDarkMode();
                  },
                  icon: isDarkMode.when(
                    data:
                        (isDarkMode) => Icon(
                          isDarkMode
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          size: 100,
                        ),
                    loading: () => CircularProgressIndicator(),
                    error: (_, _) => Icon(Icons.error, size: 100),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(sessionProvider.notifier).logout();
                  },
                  child: Text('Cerrar Sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
