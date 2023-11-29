import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/atoms/feed_chats_atom.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/feed_chats_state.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/widgets/all_chats_widget.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/widgets/app_bar_feed_chats_widget.dart';

class FeedChatsPage extends StatefulWidget {
  const FeedChatsPage({super.key});

  @override
  State<FeedChatsPage> createState() => _FeedChatsPageState();
}

class _FeedChatsPageState extends State<FeedChatsPage> {
  @override
  void initState() {
    super.initState();
    getAllChatList();
  }

  @override
  Widget build(BuildContext context) {
    final feedStates = context.select(() => feedChatsState.value);

    return Scaffold(
      appBar: const AppBarFeedChatsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/search-user/').then((_) => getAllChatList());
        },
        child: const Icon(Icons.message),
      ),
      body: Builder(
        builder: (context) {
          if (feedStates is LoadingFeedChatsState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (feedStates is ErrorFeedChatsState) {
            return const Center(
              child: Text('Erro ao buscar conversas'),
            );
          }
          if (feedStates is SuccessFeedChatsState) {
            return AllChatWidget(chatsStream: feedStates.chats);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    setInitialStatesFeedChatsAtoms();
    closeConnectionFeedChat();
    super.dispose();
  }
}
