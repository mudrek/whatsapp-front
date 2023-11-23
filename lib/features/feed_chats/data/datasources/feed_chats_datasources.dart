import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/shared/adapters/chat_adapter.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rxdart/subjects.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../../../core/http/constants.dart';
import '../../../../core/http/http_client.dart';

abstract class FeedChatsDatasources {
  Future<Stream<List<Chat>>> getAllChatsFromUser();
  Future<Unit> closeConnection();
}

class FeedChatsDatasourcesImpl implements FeedChatsDatasources {
  final HttpClient httpClient;
  final LocalStorageDatasource localStorageDatasource;

  StompClient? stompClient;
  BehaviorSubject<List<Chat>> streamChats = BehaviorSubject();

  FeedChatsDatasourcesImpl({
    required this.httpClient,
    required this.localStorageDatasource,
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
    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: '$apiKey/websocket',
          onConnect: (frame) {
            debugPrint("CONECTADO");
            _onConnect();
          },
          onWebSocketError: (dynamic error) =>
              debugPrint("ERROR =>>>> ${error.toString()}"),
        ),
      );
      stompClient?.activate();
    }
  }

  _onConnect() async {
    final loggedUser = await localStorageDatasource.getLoggedUser();

    stompClient?.subscribe(
        destination: '/chats.${loggedUser.id}',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            final response = json.decode(frame.body!) as List;
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

          debugPrint('VOLTOU >>>>> ${frame.body}');
        });
  }

  @override
  Future<Unit> closeConnection() {
    stompClient?.deactivate();
    streamChats = BehaviorSubject();
    return Future.value(unit);
  }
}
