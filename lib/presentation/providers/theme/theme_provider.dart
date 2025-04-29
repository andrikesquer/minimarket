import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pos2/core/encryption/secure_storage.dart';

part 'theme_provider.g.dart';

@riverpod
class DarkMode extends _$DarkMode {
  @override
  Future<bool> build() async {
    final isDark = await Configuration.getAppTheme();
    return isDark;
  }

  Future<void> toggleDarkMode() async {
    final newValue = !(state.value ?? false);
    state = AsyncData(newValue);
    await Configuration.saveAppTheme(newValue);
  }
}
