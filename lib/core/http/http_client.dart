import 'package:dio/dio.dart';

import '../foundation/dio_interceptor.dart';

class HttpClient {
  final Dio request;
  final DioInterceptor dioInterceptor;

  HttpClient({
    required this.request,
    required this.dioInterceptor,
  }) {
    request.interceptors.add(dioInterceptor);
  }
}
