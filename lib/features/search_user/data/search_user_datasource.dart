import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class SearchUserDatasource {
  Future<List<User>> searchUser(String username);
}

class SearchUserDatasourceImpl implements SearchUserDatasource {
  final HttpClient httpClient;

  SearchUserDatasourceImpl({required this.httpClient});

  @override
  Future<List<User>> searchUser(String username) async {
    final Response response = await httpClient.request.get(
      '$apiKey/user/searchUser',
      queryParameters: {
        'username': username,
      },
    );

    final responseList = response.data as List;

    return responseList.map((user) => UserAdapter.fromJson(user)).toList();
  }
}
