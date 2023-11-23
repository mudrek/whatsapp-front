import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/chat_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class FeedChatsDatasources {
  Future<List<Chat>> getAllChatsFromUser();
}

class FeedChatsDatasourcesImpl implements FeedChatsDatasources {
  final HttpClient httpClient;

  FeedChatsDatasourcesImpl({required this.httpClient});

  @override
  Future<List<Chat>> getAllChatsFromUser() async {
    final Response response = await httpClient.request.get(
      '$apiKey/chat',
    );

    final chatList = response.data as List;

    return chatList.map((chat) => ChatAdapter.fromJson(chat)).toList();
  }
}
