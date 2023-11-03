import 'package:dio/dio.dart';

class HttpClient {
  final Dio request;

  HttpClient({
    required this.request,
  }) {
    // request.interceptors.add(dioInterceptor);
  }
}
