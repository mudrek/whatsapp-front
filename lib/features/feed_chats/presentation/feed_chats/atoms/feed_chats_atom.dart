import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/feed_chats_state.dart';

final getAllChatList = Atom.action();

final closeConnectionFeedChat = Atom.action();

final feedChatsState = Atom<FeedChatsState>(InitialFeedChatsState());

final setInitialStatesFeedChatsAtoms = Atom.action();
