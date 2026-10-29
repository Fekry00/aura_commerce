import 'dart:async';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/utils/app_constants.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  static bool useLanFallback = false;
  static Completer<String?>? _refreshTokenCompleter;

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
    // Do not override Content-Type if request payload is FormData (needed for multipart file uploads)
    if (options.data is! FormData) {
      options.headers['Content-Type'] = 'application/json';
    }
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
      final bool alreadyRetried =
          err.requestOptions.extra['retried_fallback'] == true;

      if (!alreadyRetried && currentBaseUrl.contains('127.0.0.1')) {
        try {
          final fallbackDio = Dio(
            BaseOptions(
              baseUrl: EndPoint.fallbackLanBaseUrl,
              connectTimeout: AppConstants.connectTimeout,
              receiveTimeout: AppConstants.receiveTimeout,
              headers: Map<String, dynamic>.from(err.requestOptions.headers),
            ),
          );

          final retryOptions = err.requestOptions.copyWith(
            baseUrl: EndPoint.fallbackLanBaseUrl,
            extra: {
              ...err.requestOptions.extra,
              'retried_fallback': true,
            },
          );

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

    final bool alreadyRefreshed =
        err.requestOptions.extra['token_refreshed'] == true;

    // 2. Token refresh and concurrent request synchronization
    if (statusCode == 401 && !isAuthEndpoint && !alreadyRefreshed) {
      // If a refresh is already in-flight from another concurrent request, await its completion
      if (_refreshTokenCompleter != null) {
        try {
          final newToken = await _refreshTokenCompleter!.future;
          if (newToken != null && newToken.isNotEmpty) {
            final requestOptions = err.requestOptions;
            requestOptions.headers[ApiKey.authorization] = 'Bearer $newToken';
            requestOptions.extra['token_refreshed'] = true;

            final retryDio = Dio(
              BaseOptions(
                baseUrl: requestOptions.baseUrl.isNotEmpty
                    ? requestOptions.baseUrl
                    : (useLanFallback
                        ? EndPoint.fallbackLanBaseUrl
                        : EndPoint.baseUrl),
                connectTimeout: AppConstants.connectTimeout,
                receiveTimeout: AppConstants.receiveTimeout,
              ),
            );

            final retryResponse = await retryDio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          }
        } catch (_) {}
        return super.onError(err, handler);
      }

      final completer = Completer<String?>();
      _refreshTokenCompleter = completer;

      final token = CacheHelper.getData(key: ApiKey.token) ??
          CacheHelper.getData(key: 'CACHED_AUTH_TOKEN');
      if (token != null) {
        try {
          final activeBaseUrl = err.requestOptions.baseUrl.isNotEmpty
              ? err.requestOptions.baseUrl
              : (useLanFallback
                  ? EndPoint.fallbackLanBaseUrl
                  : EndPoint.baseUrl);

          final refreshDio = Dio(
            BaseOptions(
              baseUrl: activeBaseUrl,
              connectTimeout: AppConstants.connectTimeout,
              receiveTimeout: AppConstants.receiveTimeout,
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

            _refreshTokenCompleter = null;
            completer.complete(newToken);

            final requestOptions = err.requestOptions;
            requestOptions.headers[ApiKey.authorization] = 'Bearer $newToken';
            requestOptions.extra['token_refreshed'] = true;

            final retryResponse = await refreshDio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          } else {
            _refreshTokenCompleter = null;
            completer.complete(null);
          }
        } catch (refreshErr) {
          await CacheHelper.removeData(key: ApiKey.token);
          await CacheHelper.removeData(key: 'CACHED_AUTH_TOKEN');
          _refreshTokenCompleter = null;
          completer.completeError(refreshErr);
        }
      } else {
        _refreshTokenCompleter = null;
        completer.complete(null);
      }
    }

    super.onError(err, handler);
  }
}