import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/features/feed_chats/data/datasources/feed_chats_datasources.dart';
import 'package:kydrem_whatsapp/features/local_storage/data/datasource/local_storage_datasource.dart';
import 'package:result_dart/result_dart.dart';

abstract class FeedChatsUsecases {
  AsyncResult<Stream<List<Chat>>, WhatsappException> getAllChatsFromUser();
  AsyncResult<Unit, WhatsappException> closeConnection();
  AsyncResult<bool, WhatsappException> logout();
}

class FeedChatsUsecasesImpl implements FeedChatsUsecases {
  final FeedChatsDatasources feedChatsDatasources;
  final LocalStorageDatasource localStorageDatasource;

  FeedChatsUsecasesImpl({
    required this.feedChatsDatasources,
    required this.localStorageDatasource,
  });

  @override
  AsyncResult<Stream<List<Chat>>, WhatsappException>
      getAllChatsFromUser() async {
    return await usecaseCore(
      task: () async {
        return await feedChatsDatasources.getAllChatsFromUser();
      },
    );
  }

  @override
  AsyncResult<Unit, WhatsappException> closeConnection() async {
    return await usecaseCore(
      task: () async {
        return await feedChatsDatasources.closeConnection();
      },
    );
  }

  @override
  AsyncResult<bool, WhatsappException> logout() async {
    return await usecaseCore(
      task: () async {
        return await localStorageDatasource.logout();
      },
    );
  }
}
