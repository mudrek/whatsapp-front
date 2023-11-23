import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_message_dialog.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_text_form_field.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/atoms/search_user_atom.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/states/create_chat_state.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/states/search_user_state.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/widgets/list_search_users_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final TextEditingController _searchUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchState = context.select(() => searchUserStates.value);
    final createChatState = context.select(() => createChatUserStates.value);

    if (createChatState is LoadingCreateChatState) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }

    if (createChatState is ErrorCreateChatState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessageDialog(
          title: 'Falha ao criar o chat',
          message: createChatState.whatsappException.msg,
        ).show(context);
      });
    }

    if (createChatState is SuccessCreateChatState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessageDialog(
          title: 'Chat criado',
          message: 'O chat foi criado com sucesso!',
        ).show(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Busque o usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                AppTextFormField(
                  labelText: 'Nome de usuário',
                  controller: _searchUserController,
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () =>
                        searchUser.setValue(_searchUserController.text),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Builder(builder: (context) {
                  if (searchState is LoadingSearchUserState) {
                    return const CircularProgressIndicator();
                  }
                  if (searchState is ErrorSearchUserState) {
                    return const Text(
                        'Não foi possível encontrar este usuário no momento, tente novamente mais tarde');
                  }
                  if (searchState is SuccessSearchUserState) {
                    return ListSearchUsersWidget(
                      searchedUsers: searchState.users,
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    setInitialStatesSearchUserAtoms();
    super.dispose();
  }
}
