import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/auth/data/models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuth(AuthModel auth);

  Future<AuthModel?> getLastAuth();

  Future<void> clearAuth();

  Future<String?> getToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedTokenKey = 'CACHED_AUTH_TOKEN';
  static const String cachedUserKey = 'CACHED_AUTH_USER';

  @override
  Future<void> cacheAuth(AuthModel auth) async {
    await CacheHelper.saveData(key: ApiKey.token, value: auth.token);
    await CacheHelper.saveData(key: cachedTokenKey, value: auth.token);
    await CacheHelper.saveData(key: cachedUserKey, value: jsonEncode(auth.toJson()));
  }

  @override
  Future<AuthModel?> getLastAuth() async {
    final userJsonStr = CacheHelper.getDataString(key: cachedUserKey);
    if (userJsonStr != null && userJsonStr.isNotEmpty) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(userJsonStr);
        return AuthModel.fromJson(jsonMap);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> clearAuth() async {
    await CacheHelper.removeData(key: ApiKey.token);
    await CacheHelper.removeData(key: cachedTokenKey);
    await CacheHelper.removeData(key: cachedUserKey);
    await CacheHelper.removeData(key: 'CACHED_CART');
    await CacheHelper.removeData(key: 'CACHED_WISHLIST');
  }

  @override
  Future<String?> getToken() async {
    return CacheHelper.getDataString(key: ApiKey.token) ??
        CacheHelper.getDataString(key: cachedTokenKey);
  }
}
