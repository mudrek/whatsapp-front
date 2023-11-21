import 'package:dio/dio.dart';

class WhatsappErrorHandler {
  final String? message;
  final String? statusCode;

  WhatsappErrorHandler({required this.message, required this.statusCode});

  static WhatsappErrorHandler? build(DioException dioException) {
    try {
      if (dioException.response == null) {
        return null;
      }

      return WhatsappErrorHandler(
        message: dioException.response?.data['message'],
        statusCode: dioException.response?.data['code'],
      );
    } catch (e) {
      return null;
    }
  }
}
