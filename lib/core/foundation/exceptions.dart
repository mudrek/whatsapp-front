abstract class WhatsappException {
  final String title;
  final String msg;

  const WhatsappException(
      {this.msg = 'Ocorreu um erro', this.title = 'Este é um erro genérico'});
}

class ServerException extends WhatsappException {
  const ServerException({
    String msg = 'Server Failure',
  }) : super(msg: msg);
}

class GenericException extends WhatsappException {
  const GenericException({
    String msg = 'Generic Failure',
  }) : super(msg: msg);
}
