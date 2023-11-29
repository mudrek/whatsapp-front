import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/do_logout_state.dart';

final doLogoutState = Atom<DoLogoutState>(InitialDoLogoutState());

final doLogout = Atom.action();
