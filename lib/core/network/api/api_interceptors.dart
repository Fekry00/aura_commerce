import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CacheHelper.getData(key: ApiKey.token);
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
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;

    final isAuthEndpoint = path.contains(EndPoint.login) ||
        path.contains(EndPoint.register) ||
        path.contains(EndPoint.refreshToken);

    if (statusCode == 401 && !isAuthEndpoint) {
      final token = CacheHelper.getData(key: ApiKey.token);
      if (token != null) {
        try {
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: EndPoint.baseUrl,
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