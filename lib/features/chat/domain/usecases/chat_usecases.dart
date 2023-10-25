import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/features/chat/data/datasources/chat_datasource.dart';
import 'package:kydrem_whatsapp/features/chat/domain/entities/chat_message_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/foundation/usecase_core.dart';

abstract class ChatUsecases {
  AsyncResult<Stream<List<ChatMessageEntity>>, WhatsappException> connectToChat(
      ChatMessageEntity chatMessageEntity);

  AsyncResult<Unit, WhatsappException> sendMessage(
      ChatMessageEntity chatMessageEntity);

  AsyncResult<Unit, WhatsappException> closeConnection();
}

class ChatUsecasesImpl implements ChatUsecases {
  final ChatDatasource chatDatasource;

  ChatUsecasesImpl({required this.chatDatasource});

  @override
  AsyncResult<Stream<List<ChatMessageEntity>>, WhatsappException> connectToChat(
      ChatMessageEntity chatMessageEntity) async {
    return await usecaseCore(
      task: () async {
        return chatDatasource.connectToChat(chatMessageEntity);
      },
    );
  }

  @override
  AsyncResult<Unit, WhatsappException> sendMessage(
      ChatMessageEntity chatMessageEntity) async {
    return await usecaseCore(
      task: () async {
        return chatDatasource.sendMessage(chatMessageEntity);
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
}
