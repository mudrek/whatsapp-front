import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kydrem_whatsapp/core/http/constants.dart';
import 'package:kydrem_whatsapp/core/http/http_client.dart';
import 'package:kydrem_whatsapp/core/services/websocket_service.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/message_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/message.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/chat/data/adapters/send_message_dto_adapter.dart';
import 'package:kydrem_whatsapp/features/chat/domain/dtos/send_message_dto.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rxdart/subjects.dart';

abstract class ChatDatasource {
  Future<Stream<List<Message>>> getAllMessagesFromChat(int chatId);
  Future<Message> sendMessage(SendMessageDTO sendMessageDTO);

  Future<Unit> closeConnection();
}

class ChatDatasourceImpl implements ChatDatasource {
  final HttpClient httpClient;
  final LocalStorageDatasource localStorageDatasource;
  final WebsocketService websocketService;

  BehaviorSubject<List<Message>> streamMessages = BehaviorSubject();

  ChatDatasourceImpl({
    required this.httpClient,
    required this.localStorageDatasource,
    required this.websocketService,
  });

  @override
  Future<Stream<List<Message>>> getAllMessagesFromChat(int chatId) async {
    final Response response = await httpClient.request.get(
      '$apiKey/message',
      queryParameters: {
        "chatId": chatId,
      },
    );

    final messageList = response.data as List;

    final loggedUser = await localStorageDatasource.getLoggedUser();

    final messages = messageList.map((message) {
      final messageEntity = MessageAdapter.fromJson(message);

      messageEntity.isLoggedUserSentMessage =
          loggedUser.id == messageEntity.sender.id;

      return messageEntity;
    }).toList();

    streamMessages.add(messages);

    await websocketService.connection(
      urlPath: '/chat.$chatId',
      onConnect: (body) => _onConnect(body, loggedUser),
    );

    return streamMessages;
  }

  _onConnect(String body, User loggedUser) async {
    final jsonBody = json.decode(body);
    if (jsonBody is List) {
      final response = json.decode(body) as List;
      final messages = response.map((message) {
        final messageEntity = MessageAdapter.fromJson(message);

        messageEntity.isLoggedUserSentMessage =
            loggedUser.id == messageEntity.sender.id;

        return messageEntity;
      }).toList();

      streamMessages.add(messages);
    }
  }

  @override
  Future<Message> sendMessage(SendMessageDTO sendMessageDTO) async {
    final Response response = await httpClient.request.post(
      '$apiKey/message',
      data: SendMessageDTOAdapter.toJson(sendMessageDTO),
    );

    return MessageAdapter.fromJson(response.data);
  }

  @override
  Future<Unit> closeConnection() {
    websocketService.closeConnection();
    return Future.value(unit);
  }
}
