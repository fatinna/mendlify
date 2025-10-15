import 'package:mendlify/core/data/remote/token/itoken_service.dart';
import 'package:mendlify/core/data/remote/token/token_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'http_status/status_code.dart';

final networkServiceInterceptorProvider =
    Provider.family<NetworkServiceInterceptor, Dio>((ref, dio) {
  final tokenService = ref.watch(tokenServiceProvider(dio));
  return NetworkServiceInterceptor(tokenService, dio);
});

final class NetworkServiceInterceptor extends Interceptor {
  final ITokenService _tokenService;
  final Dio _dio;

  NetworkServiceInterceptor(this._tokenService, this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _tokenService.getAccessToken();
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == unauthorized) {
      final token = await _tokenService.getRefreshToken();
      try {
        final result = await _tokenService.refreshToken(token);
        final accessToken = result.data.accessToken;
        final refreshToken = result.data.refreshToken;
        await _tokenService.saveToken(accessToken, refreshToken);
        final options = err.requestOptions;
        //update request headers with new access token
        options.headers['Authorization'] = 'Bearer $accessToken';
        //repeat the request with new access token
        handler.resolve(await _dio.fetch(options));
      } on DioException catch (e) {
        if (e.response?.statusCode == refreshTokenExpired) {
          //clear token
          await _tokenService.clearToken();
          return handler.next(err);
        }
        //continue with error
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
