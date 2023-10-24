import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kydrem_whatsapp/features/chat/data/adapters/chat_message_entity_adapter.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

abstract class ChatDatasource {
  Future<Stream<List<ChatMessageEntity>>> connectToChat(
      ChatMessageEntity chatMessageEntity);
}

class ChatDatasourceImpl implements ChatDatasource {
  StompClient? stompClient;
  StreamController<List<ChatMessageEntity>> streamChatMessageEntities =
      StreamController.broadcast();
  List<ChatMessageEntity> listChatMessageEntities = List.empty(growable: true);
  final socketUrl = 'http://localhost:8080/websocket';

  @override
  Future<Stream<List<ChatMessageEntity>>> connectToChat(
      ChatMessageEntity chatMessageEntity) async {
    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: socketUrl,
          onConnect: (frame) {
            debugPrint("CONECTADO");
            onConnect(frame, chatMessageEntity);
          },
          onWebSocketError: (dynamic error) =>
              debugPrint("ERROR =>>>> ${error.toString()}"),
        ),
      );
      stompClient?.activate();
    }

    return streamChatMessageEntities.stream;
  }

  void onConnect(StompFrame frame, ChatMessageEntity chatMessageEntity) {
    stompClient?.subscribe(
        destination: '/topic/public',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            final chatMessageEntity =
                ChatMessageEntityAdapter.fromJson(json.decode(frame.body!));
            listChatMessageEntities.add(chatMessageEntity);
            streamChatMessageEntities.add(listChatMessageEntities);
          }

          debugPrint('VOLTOU >>>>> ${frame.body}');
        });

    stompClient?.send(
      destination: '/app/chat.register',
      body: json.encode(
        ChatMessageEntityAdapter.toJson(
          chatMessageEntity,
        ),
      ),
    );
  }
}
