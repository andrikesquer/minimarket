import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserCredentials {

  static final _storage = FlutterSecureStorage();

  static void saveCredentials (String email, int idSubscription) async {
    FlutterSecureStorage.setMockInitialValues({});

    try {
      await _storage.write(key: 'email', value: email);
      await _storage.write(key: 'idSubscription', value: '$idSubscription');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<String?>> getCredentials () async {
    String? emailValue = await _storage.read(key: 'email');
    String? idSubscriptionValue = await _storage.read(key: 'idSubscription');

    List<String?> value = [];

    value.add(emailValue);
    value.add(idSubscriptionValue);

    return value;
  }

  static void cleanCredentials () async {
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'idSubscription');
  }
}
