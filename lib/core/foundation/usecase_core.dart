import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/foundation/whatsapp_error_handler.dart';
import 'package:result_dart/result_dart.dart';

import 'exceptions.dart';

AsyncResult<T, WhatsappException> usecaseCore<T extends Object>({
  required Future<T> Function() task,
  WhatsappException? Function(Object e)? onException,
}) async {
  try {
    final result = await task();
    return Result.success(result);
  } catch (e, stacktrace) {
    WhatsappErrorHandler? whatsappErrorHandler;
    if (e is DioException) {
      whatsappErrorHandler = WhatsappErrorHandler.build(e);
      debugPrint(
          'STATUS CODE: ${e.response?.statusCode}\nBody: ${e.response.toString()}');
    } else if (e is Exception || e is TypeError) {
      debugPrint(stacktrace.toString());
    } else {
      debugPrint(stacktrace.toString());
    }
    final failure = onException?.call(e);
    if (failure != null) {
      return Result.failure(failure);
    }

    if (whatsappErrorHandler != null && whatsappErrorHandler.message != null) {
      return Result.failure(
        GenericException(
          msg: whatsappErrorHandler.message!,
        ),
      );
    }

    return Result.failure(const GenericException());
  }
}
