import 'package:kydrem_whatsapp/core/foundation/exceptions.dart';

class WrongUsernameOrPasswordLoginException extends WhatsappException {
  const WrongUsernameOrPasswordLoginException({
    String msg = 'Credenciais inválidas',
  }) : super(msg: msg);
}
