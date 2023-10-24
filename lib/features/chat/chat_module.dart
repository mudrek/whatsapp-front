import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/chat/data/datasources/chat_datasource.dart';
import 'package:kydrem_whatsapp/features/chat/domain/usecases/chat_usecases.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/chat_page.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/join_chat_page.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/join_chat/reducers/join_chat_reducer.dart';

class ChatModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ChatDatasource>(ChatDatasourceImpl.new);
    i.add<ChatUsecases>(ChatUsecasesImpl.new);
    i.addSingleton<JoinChatReducer>(JoinChatReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const JoinChatPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/text-chat',
      child: (context) => ChatPage(
        chatMessageEntity: r.args.data,
      ),
      transition: TransitionType.fadeIn,
    );
  }
}
