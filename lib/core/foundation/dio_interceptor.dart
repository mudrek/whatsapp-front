import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kydrem_whatsapp/features/local_storage/domain/usecases/local_storage_usecases.dart';

class DioInterceptor extends Interceptor {
  final LocalStorageUsecases localStorageUsecases;
  final Dio dio;

  DioInterceptor({
    required this.localStorageUsecases,
    required this.dio,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['requiresToken'] != null &&
        !options.headers['requiresToken']) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.headers.remove('requiresToken'); //remove the auxiliary header
      return handler.next(options);
    }

    final getBearerToken = await localStorageUsecases.getBearerToken();

    final bearerToken = getBearerToken.fold(
      (bearerToken) => bearerToken,
      (failure) => null,
    );

    if (bearerToken == null) {
      // if the user is not authenticated, then just continue to the next interceptor
      return handler.next(options);
    }

    // check if tokens have already expired or not
    // I use jwt_decoder package
    // Note: ensure your tokens has "exp" claim
    final bearerTokenHasExpired = JwtDecoder.isExpired(bearerToken);

    if (bearerTokenHasExpired) {
      _performLogout();

      final error = DioException(
          requestOptions: options, type: DioExceptionType.badCertificate);

      return handler.reject(error);
    }

    // add access token to the request header
    options.headers['Authorization'] = bearerToken;
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403) {
      _performLogout();
    }

    return handler.next(err);
  }

  Future<void> _performLogout() async {
    await localStorageUsecases.logout();
    Modular.to.navigate('/presenting/');
  }
}
