import '../../../../core/foundation/exceptions.dart';

class LocalStorageUserNotLogged extends WhatsappException {
  const LocalStorageUserNotLogged({
    String msg = 'User is not Logged',
  }) : super(msg: msg);
}
