import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/http/constants.dart';
import 'package:kydrem_whatsapp/core/http/http_client.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

abstract class SignupDatasource {
  Future<User> signupUser(User user);
}

class SignupDatasourceImpl implements SignupDatasource {
  final HttpClient httpClient;

  SignupDatasourceImpl({required this.httpClient});

  @override
  Future<User> signupUser(User user) async {
    final Response response = await httpClient.request.post(
      '$apiKey/user/signup',
      data: UserAdapter.toJson(
        user,
      ),
      options: Options(
        headers: {
          'requiresToken': false,
        },
      ),
    );

    return UserAdapter.fromJson(response.data);
  }
}
