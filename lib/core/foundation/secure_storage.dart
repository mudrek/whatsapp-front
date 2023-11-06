import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<String?> readValue(String key);
  Future<void> writeValue(String key, String value);
  Future<Map<String, String>> allValues();
  Future<void> deleteValue(String key);
  Future<void> deleteAllValues();
}

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl({required this.storage});

  @override
  Future<Map<String, String>> allValues() async {
    return await storage.readAll(
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<void> deleteAllValues() async {
    return await storage.deleteAll(
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<void> deleteValue(String key) async {
    return await storage.delete(
      key: key,
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<String?> readValue(String key) async {
    return await storage.read(
      key: key,
      aOptions: _getAndroidOptions(),
    );
  }

  @override
  Future<void> writeValue(String key, String value) async {
    return await storage.write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
    );
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
