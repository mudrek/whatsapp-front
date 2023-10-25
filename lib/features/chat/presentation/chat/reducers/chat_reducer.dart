import 'package:asp/asp.dart';
import 'package:kydrem_whatsapp/features/chat/domain/usecases/chat_usecases.dart';
import 'package:kydrem_whatsapp/features/chat/presentation/chat/atoms/chat_atom.dart';
import 'package:result_dart/result_dart.dart';

class ChatReducer extends Reducer {
  final ChatUsecases chatUsecases;

  ChatReducer({required this.chatUsecases}) {
    on(() => [sendMessage.value], _sendMessage);
  }

  _sendMessage() async {
    final chatMessageEntity = sendMessage.value;
    await chatUsecases.sendMessage(chatMessageEntity).fold(
          (chatMessageEntity) {},
          (error) {},
        );
  }
}
