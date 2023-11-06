import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/app_module.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats_page/feed_chats_page.dart';

class FeedChatsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const FeedChatsPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
