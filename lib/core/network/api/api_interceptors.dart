import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  static bool useLanFallback = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (useLanFallback && options.baseUrl.contains('127.0.0.1')) {
      options.baseUrl = EndPoint.fallbackLanBaseUrl;
    }

    final token = CacheHelper.getData(key: ApiKey.token) ??
        CacheHelper.getData(key: 'CACHED_AUTH_TOKEN');
    if (token != null) {
      options.headers[ApiKey.authorization] = 'Bearer $token';
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 1. Connection error or timeout failover between 127.0.0.1 and LAN IP
    final isTimeoutOrConnError = err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout;

    if (isTimeoutOrConnError) {
      final currentBaseUrl = err.requestOptions.baseUrl;
      final bool alreadyRetried = err.requestOptions.extra['retried_fallback'] == true;

      if (!alreadyRetried && currentBaseUrl.contains('127.0.0.1')) {
        try {
          final fallbackDio = Dio(
            BaseOptions(
              baseUrl: EndPoint.fallbackLanBaseUrl,
              connectTimeout: const Duration(seconds: 4),
              receiveTimeout: const Duration(seconds: 4),
              headers: Map<String, dynamic>.from(err.requestOptions.headers),
            ),
          );

          final retryOptions = err.requestOptions;
          retryOptions.baseUrl = EndPoint.fallbackLanBaseUrl;
          retryOptions.extra['retried_fallback'] = true;

          final retryResponse = await fallbackDio.fetch(retryOptions);
          useLanFallback = true;
          return handler.resolve(retryResponse);
        } catch (_) {}
      }
    }

    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    final isAuthEndpoint = path.contains(EndPoint.login) ||
        path.contains(EndPoint.register) ||
        path.contains(EndPoint.refreshToken);

    if (statusCode == 401 && !isAuthEndpoint) {
      final token = CacheHelper.getData(key: ApiKey.token) ??
          CacheHelper.getData(key: 'CACHED_AUTH_TOKEN');
      if (token != null) {
        try {
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: err.requestOptions.baseUrl.isNotEmpty
                  ? err.requestOptions.baseUrl
                  : EndPoint.baseUrl,
              headers: {
                ApiKey.authorization: 'Bearer $token',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

          final response = await refreshDio.post(EndPoint.refreshToken);
          final responseData = response.data;
          final newToken = (responseData is Map<String, dynamic>)
              ? (responseData['data']?['token'] ?? responseData['token'])
              : null;

          if (newToken != null && newToken is String && newToken.isNotEmpty) {
            await CacheHelper.saveData(key: ApiKey.token, value: newToken);
            await CacheHelper.saveData(
              key: 'CACHED_AUTH_TOKEN',
              value: newToken,
            );

            final requestOptions = err.requestOptions;
            requestOptions.headers[ApiKey.authorization] = 'Bearer $newToken';

            final retryResponse = await refreshDio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          }
        } catch (_) {
          // Token refresh failed, continue throwing 401
        }
      }
    }

    super.onError(err, handler);
  }
}