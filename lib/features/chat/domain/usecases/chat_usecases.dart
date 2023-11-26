import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/shared/entities/message.dart';
import 'package:kydrem_whatsapp/features/chat/data/datasources/chat_datasource.dart';
import 'package:kydrem_whatsapp/features/chat/domain/dtos/send_message_dto.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/foundation/usecase_core.dart';

abstract class ChatUsecases {
  AsyncResult<Stream<List<Message>>, WhatsappException> getAllMessagesFromChat(
      int chatID);

  AsyncResult<Message, WhatsappException> sendMessage(
      SendMessageDTO sendMessageDTO);

  AsyncResult<Unit, WhatsappException> closeConnection();
}

class ChatUsecasesImpl implements ChatUsecases {
  final ChatDatasource chatDatasource;

  ChatUsecasesImpl({required this.chatDatasource});

  @override
  AsyncResult<Stream<List<Message>>, WhatsappException> getAllMessagesFromChat(
      int chatID) async {
    return await usecaseCore(
      task: () async {
        return chatDatasource.getAllMessagesFromChat(chatID);
      },
    );
  }

  @override
  AsyncResult<Unit, WhatsappException> closeConnection() async {
    return await usecaseCore(
      task: () async {
        return chatDatasource.closeConnection();
      },
    );
  }

  @override
  AsyncResult<Message, WhatsappException> sendMessage(
      SendMessageDTO sendMessageDTO) async {
    return await usecaseCore(
      task: () async {
        return chatDatasource.sendMessage(sendMessageDTO);
      },
    );
  }
}
