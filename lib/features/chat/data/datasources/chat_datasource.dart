import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kydrem_whatsapp/features/chat/data/adapters/chat_message_entity_adapter.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rxdart/subjects.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

abstract class ChatDatasource {
  Future<Stream<List<ChatMessageEntity>>> connectToChat(
      ChatMessageEntity chatMessageEntity);

  Future<Unit> sendMessage(ChatMessageEntity chatMessageEntity);
}

class ChatDatasourceImpl implements ChatDatasource {
  StompClient? stompClient;
  BehaviorSubject<List<ChatMessageEntity>> streamChatMessageEntities =
      BehaviorSubject();
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
            _onConnect(frame, chatMessageEntity);
          },
          onWebSocketError: (dynamic error) =>
              debugPrint("ERROR =>>>> ${error.toString()}"),
        ),
      );
      stompClient?.activate();
    }

    return streamChatMessageEntities.stream;
  }

  void _onConnect(StompFrame frame, ChatMessageEntity chatMessageEntity) {
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

  @override
  Future<Unit> sendMessage(ChatMessageEntity chatMessageEntity) {
    stompClient?.send(
      destination: '/app/chat.send',
      body: json.encode(
        ChatMessageEntityAdapter.toJson(
          chatMessageEntity,
        ),
      ),
    );

    return Future.value(unit);
  }
}
