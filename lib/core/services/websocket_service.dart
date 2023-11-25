import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/http/constants.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WebsocketService {
  StompClient? stompClient;

  connection({required String urlPath, Function(String)? onConnect}) async {
    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: '$apiKey/websocket',
          onConnect: (frame) {
            debugPrint("CONECTADO");
            _onConnect(urlPath, onConnect);
          },
          onWebSocketError: (dynamic error) =>
              debugPrint("ERROR =>>>> ${error.toString()}"),
        ),
      );
      stompClient?.activate();
    }
  }

  closeConnection() {
    stompClient?.deactivate();
  }

  _onConnect(String urlPath, Function(String)? onConnect) async {
    stompClient?.subscribe(
      destination: urlPath,
      callback: (StompFrame frame) {
        if (frame.body != null) {
          onConnect?.call(frame.body!);
        }

        debugPrint('VOLTOU >>>>> ${frame.body}');
      },
    );
  }
}
