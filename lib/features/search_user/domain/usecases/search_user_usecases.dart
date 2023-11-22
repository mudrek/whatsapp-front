import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';
import 'package:kydrem_whatsapp/core/foundation/usecase_core.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/search_user/data/datasources/search_user_datasource.dart';
import 'package:kydrem_whatsapp/features/search_user/domain/dto/create_chat_dto.dart';
import 'package:result_dart/result_dart.dart';

abstract class SearchUserUsecases {
  AsyncResult<List<User>, WhatsappException> searchUser(String username);
  AsyncResult<Chat, WhatsappException> createChat(CreateChatDTO chatDTO);
}

class SearchUserUsecasesImpl implements SearchUserUsecases {
  final SearchUserDatasource searchUserDatasource;

  SearchUserUsecasesImpl({
    required this.searchUserDatasource,
  });

  @override
  AsyncResult<List<User>, WhatsappException> searchUser(String username) async {
    return await usecaseCore(
      task: () async {
        return await searchUserDatasource.searchUser(username);
      },
    );
  }

  @override
  AsyncResult<Chat, WhatsappException> createChat(CreateChatDTO chatDTO) async {
    return await usecaseCore(
      task: () async {
        return await searchUserDatasource.createChat(chatDTO);
      },
    );
  }
}
