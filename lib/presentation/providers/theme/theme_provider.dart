import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/*
@riverpod
class AsyncDarkMode extends _$AsyncDarkMode {
  Future<bool> _getStorageTheme() async {
    final bool storedTheme = await Configuration.getAppTheme();
    // print('$storedTheme');
    //
    // if (storedTheme == true) {
    //   print('modo oscuro');
    // } else {
    //   print('modo claro');
    // }
    return storedTheme;
  }

  @override
  FutureOr<bool> build() async {
    return _getStorageTheme();
  }

  void toggleDarkMode() async {
    final bool value = await _getStorageTheme();

    state = !value;

    Configuration.saveAppTheme(state);
  }
}
 */

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() => false;

  void toggleDarkMode() {
    state = !state;
  }
}
