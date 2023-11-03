import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/features/login/data/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class LoginDatasource {
  Future<User> doLogin(User user);
}

class LoginDatasourceImpl implements LoginDatasource {
  final HttpClient httpClient;

  LoginDatasourceImpl({required this.httpClient});

  @override
  Future<User> doLogin(User user) async {
    final Response response =
        await httpClient.request.post('$apiKey/user/login');

    return UserAdapter.fromJson(response.data);
  }
}
