import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/features/login/data/adapters/login_user_dto_adapter.dart';
import 'package:kydrem_whatsapp/features/login/data/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';
import 'package:kydrem_whatsapp/features/login/domain/entities/user.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class LoginDatasource {
  Future<User> doLogin(LoginUserDTO loginUserDTO);
}

class LoginDatasourceImpl implements LoginDatasource {
  final HttpClient httpClient;

  LoginDatasourceImpl({required this.httpClient});

  @override
  Future<User> doLogin(LoginUserDTO loginUserDTO) async {
    final Response response = await httpClient.request.post(
      '$apiKey/user/login',
      data: LoginUserDTOAdapter.toJson(
        loginUserDTO,
      ),
    );

    return UserAdapter.fromJson(response.data);
  }
}
