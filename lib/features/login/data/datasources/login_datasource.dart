import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/login/data/adapters/login_user_dto_adapter.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class LoginDatasource {
  Future<(User, String)> doLogin(LoginUserDTO loginUserDTO);
}

class LoginDatasourceImpl implements LoginDatasource {
  final HttpClient httpClient;

  LoginDatasourceImpl({required this.httpClient});

  @override
  Future<(User, String)> doLogin(LoginUserDTO loginUserDTO) async {
    final Response response = await httpClient.request.post(
      '$apiKey/user/login',
      data: LoginUserDTOAdapter.toJson(
        loginUserDTO,
      ),
      options: Options(
        headers: {
          'requiresToken': false,
        },
      ),
    );

    final String? bearerToken = response.headers.value('Authorization');

    if (bearerToken == null) {
      throw const GenericException();
    }

    return (UserAdapter.fromJson(response.data), bearerToken);
  }
}
