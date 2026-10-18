import 'package:aura/core/databases/cache/cache_helper.dart';
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
    // await cacheHelper.saveData(key: cachedTokenKey, value: auth.token);
    // await cacheHelper.saveData(key: cachedUserKey, value: auth.toJson());
  }

  @override
  Future<AuthModel?> getLastAuth() async {
    return _buildDefaultAuth();
  }

  @override
  Future<void> clearAuth() async {
    // await cacheHelper.removeData(key: cachedTokenKey);
    // await cacheHelper.removeData(key: cachedUserKey);
  }

  @override
  Future<String?> getToken() async {
    // return cacheHelper.getData(key: cachedTokenKey) as String?;
    return 'aura_vault_jwt_token_mock';
  }

  AuthModel _buildDefaultAuth() {
    return const AuthModel(
      token: 'aura_vault_jwt_token_mock',
      userId: '1',
      name: 'Ahmed Mohamed',
      email: 'ahmed@aura.luxury',
      phone: '+20 100 000 0000',
      membershipTier: 'Private Client',
      avatarUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
    );
  }
}
