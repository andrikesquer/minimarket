import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();

class UserCredentials {
  static saveCredentials(String email, int idSubscription) async {
    try {
      await _storage.write(key: 'email', value: email);
      await _storage.write(key: 'idSubscription', value: '$idSubscription');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<String?>> getCredentials() async {
    String? emailValue = await _storage.read(key: 'email');
    String? idSubscriptionValue = await _storage.read(key: 'idSubscription');

    List<String?> value = [];

    value.add(emailValue);
    value.add(idSubscriptionValue);

    return value;
  }

  static cleanCredentials() async {
    try {
      await _storage.delete(key: 'email');
      await _storage.delete(key: 'idSubscription');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class Configuration {
  static saveAppTheme(bool isDarkMode) async {
    await _storage.write(key: 'isDarkMode', value: '$isDarkMode');
  }

  static Future<String?> getData() async {
    return Future.value(_storage.read(key: 'isDarkMode'));
  }

  static Future<bool> getAppTheme() async {
    Future<String?> stringFuture = getData();
    String? message = await stringFuture;
    bool isDarkMode = await message?.toLowerCase() == 'true';
    return isDarkMode;
  }
}
