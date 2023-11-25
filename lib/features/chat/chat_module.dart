import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/core/shared/entities/chat.dart';
import 'package:kydrem_whatsapp/features/chat/data/datasources/chat_datasource.dart';
import 'package:kydrem_whatsapp/features/chat/domain/usecases/chat_usecases.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/chat_page.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/reducers/chat_reducer.dart';

class ChatModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<ChatDatasource>(ChatDatasourceImpl.new);
    i.add<ChatUsecases>(ChatUsecasesImpl.new);
    i.addSingleton<ChatReducer>(ChatReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => ChatPage(
        chat: r.args.data as Chat,
      ),
      transition: TransitionType.fadeIn,
    );
  }
}
