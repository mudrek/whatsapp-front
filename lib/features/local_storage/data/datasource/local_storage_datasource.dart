import 'dart:convert';

import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/secure_storage.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

abstract class LocalStorageDatasource {
  Future<User> saveUserLocalStorage(User user);
  Future<User> getLoggedUser();
  Future<String> getBearerToken();
  Future<String> saveBearerToken(String bearerToken);
  Future<bool> logout();
}

class LocalStorageDatasourceImpl implements LocalStorageDatasource {
  final SecureStorage secureStorage;

  LocalStorageDatasourceImpl({required this.secureStorage});

  @override
  Future<String> getBearerToken() async {
    final String? getBearerToken =
        await secureStorage.readValue('bearer_token');

    if (getBearerToken == null) {
      throw const GenericException();
    }

    return getBearerToken;
  }

  @override
  Future<User> getLoggedUser() async {
    final String? userJson = await secureStorage.readValue('user');

    if (userJson == null) {
      throw const GenericException();
    }

    return UserAdapter.fromJson(json.decode(userJson));
  }

  @override
  Future<String> saveBearerToken(String bearerToken) async {
    await secureStorage.writeValue('bearer_token', bearerToken);
    return getBearerToken();
  }

  @override
  Future<User> saveUserLocalStorage(User user) async {
    await secureStorage.writeValue(
      'user',
      json.encode(
        UserAdapter.toJson(user),
      ),
    );
    return getLoggedUser();
  }

  @override
  Future<bool> logout() async {
    await secureStorage.deleteValue('bearer_token');
    await secureStorage.deleteValue('user');

    return true;
  }
}
