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
}