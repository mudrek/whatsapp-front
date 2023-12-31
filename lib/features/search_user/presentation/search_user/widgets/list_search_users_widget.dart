import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_choices_dialog.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_profile_image.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/search_user/domain/dto/create_chat_dto.dart';
import 'package:kydrem_whatsapp/features/search_user/presentation/search_user/atoms/search_user_atom.dart';

class ListSearchUsersWidget extends StatelessWidget {
  final List<User> searchedUsers;

  const ListSearchUsersWidget({super.key, required this.searchedUsers});

  @override
  Widget build(BuildContext context) {
    return searchedUsers.isEmpty
        ? const Text('Nenhum usuário encontrado com esse nome')
        : ListView.builder(
            itemCount: searchedUsers.length,
            itemBuilder: (context, index) {
              final user = searchedUsers[index];

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      AppChoiceDialog(
                        title: 'Iniciar conversa',
                        message:
                            'Deseja iniciar uma conversa com esse usuário?',
                        buttonOkText: 'Iniciar',
                        buttonOkOnPressed: () => createChatUser
                            .setValue(CreateChatDTO(toUser: user.id!)),
                        buttonCancelText: 'Cancelar',
                      ).show(context);
                    },
                    child: Container(
                      color: Colors.grey[900],
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          const AppProfileImage(),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nome: ${user.name}'),
                                Text('Usuário: ${user.username}'),
                              ],
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              );
            },
          );
  }
}
