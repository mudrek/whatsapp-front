import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/atoms/do_logout_atom.dart';
import 'package:kydrem_whatsapp/features/feed_chats/presentation/feed_chats/states/do_logout_state.dart';

class AppBarFeedChatsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarFeedChatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final doLogoutStates = context.select(() => doLogoutState.value);

    if (doLogoutStates is SuccessDoLogoutState) {
      Modular.to.navigate('/presenting/');
    }

    return AppBar(
      title: const Text('Conversas'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: _onClickPopupMenu,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'sair',
                  child: Text('Sair'),
                )
              ];
            },
          ),
        ),
      ],
    );
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case 'sair':
        doLogout();
        return;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
