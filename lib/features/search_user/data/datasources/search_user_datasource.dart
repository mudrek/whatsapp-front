import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/chat_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/user_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/search_user/data/adapters/create_chat_dto_adapter.dart';
import 'package:kydrem_whatsapp/features/search_user/domain/dto/create_chat_dto.dart';

import '../../../../../core/http/constants.dart';
import '../../../../../core/http/http_client.dart';

abstract class SearchUserDatasource {
  Future<List<User>> searchUser(String username);
  Future<Chat> createChat(CreateChatDTO createChatDTO);
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

  @override
  Future<Chat> createChat(CreateChatDTO createChatDTO) async {
    final Response response = await httpClient.request.post(
      '$apiKey/chat',
      data: CreateChatDTOAdapter.toJson(createChatDTO),
    );

    return ChatAdapter.fromJson(response.data);
  }
}
