import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/feed_chats/data/datasources/feed_chats_datasources.dart';
import 'package:kydrem_whatsapp/features/feed_chats/domain/usecases/feed_chats_usecases.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/feed_chats_page.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/reducers/do_logout_reducer.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/reducers/feed_chats_reducer.dart';

class FeedChatsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<FeedChatsDatasources>(FeedChatsDatasourcesImpl.new);
    i.addSingleton<FeedChatsUsecases>(FeedChatsUsecasesImpl.new);
    i.addSingleton<FeedChatsReducer>(FeedChatsReducer.new);
    i.addSingleton<DoLogoutReducer>(DoLogoutReducer.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const FeedChatsPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
