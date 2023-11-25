import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/services/websocket_service.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/chat_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rxdart/subjects.dart';
import 'package:stomp_dart_client/stomp.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class FeedChatsDatasources {
  Future<Stream<List<Chat>>> getAllChatsFromUser();
  Future<Unit> closeConnection();
}

class FeedChatsDatasourcesImpl implements FeedChatsDatasources {
  final HttpClient httpClient;
  final LocalStorageDatasource localStorageDatasource;
  final WebsocketService websocketService;

  StompClient? stompClient;
  BehaviorSubject<List<Chat>> streamChats = BehaviorSubject();

  FeedChatsDatasourcesImpl({
    required this.httpClient,
    required this.localStorageDatasource,
    required this.websocketService,
  });

  @override
  Future<Stream<List<Chat>>> getAllChatsFromUser() async {
    final Response response = await httpClient.request.get(
      '$apiKey/chat',
    );

    final chatList = response.data as List;
    final loggedUser = await localStorageDatasource.getLoggedUser();

    final chats = chatList.map((chat) {
      final chatEntity = ChatAdapter.fromJson(chat);

      if (chatEntity.fromUser.id != loggedUser.id) {
        chatEntity.sender = chatEntity.fromUser;
      } else {
        chatEntity.sender = chatEntity.toUser;
      }

      return chatEntity;
    }).toList();

    await _connectToChat();

    streamChats.add(chats);

    return streamChats.stream;
  }

  _connectToChat() async {
    final loggedUser = await localStorageDatasource.getLoggedUser();

    await websocketService.connection(
      urlPath: '/chats.${loggedUser.id}',
      onConnect: (body) => _onConnect(body, loggedUser),
    );
  }

  _onConnect(String body, User loggedUser) async {
    final response = json.decode(body) as List;
    final responseChats = response.map((chat) {
      final chatEntity = ChatAdapter.fromJson(chat);

      if (chatEntity.fromUser.id != loggedUser.id) {
        chatEntity.sender = chatEntity.fromUser;
      } else {
        chatEntity.sender = chatEntity.toUser;
      }

      return chatEntity;
    }).toList();

    streamChats.add(responseChats);
  }

  @override
  Future<Unit> closeConnection() {
    websocketService.closeConnection();
    streamChats = BehaviorSubject();
    return Future.value(unit);
  }
}
