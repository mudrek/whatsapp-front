import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/features/feed_chats/data/datasources/feed_chats_datasources.dart';
import 'package:result_dart/result_dart.dart';

abstract class FeedChatsUsecases {
  AsyncResult<List<Chat>, WhatsappException> getAllChatsFromUser();
}

class FeedChatsUsecasesImpl implements FeedChatsUsecases {
  final FeedChatsDatasources feedChatsDatasources;

  FeedChatsUsecasesImpl({required this.feedChatsDatasources});

  @override
  AsyncResult<List<Chat>, WhatsappException> getAllChatsFromUser() async {
    return await usecaseCore(
      task: () async {
        return await feedChatsDatasources.getAllChatsFromUser();
      },
    );
  }
}
