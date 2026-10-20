import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/profile/data/models/profile_model.dart';
import 'package:aura/features/profile/data/models/sub_models/concierge_liaison_model.dart';
import 'package:aura/features/profile/data/models/sub_models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel> getLastProfile();

  Future<void> cacheProfile(ProfileModel profileToCache);

  Future<bool> updateProfileLocal({
    required String name,
    required String phone,
  });

  Future<bool> signOutLocal();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  const ProfileLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedProfileKey = 'CACHED_PROFILE';

  @override
  Future<ProfileModel> getLastProfile() async {
    final cachedStr = CacheHelper.getDataString(key: cachedProfileKey);
    if (cachedStr != null && cachedStr.isNotEmpty) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(cachedStr);
        return ProfileModel.fromJson(jsonMap);
      } catch (_) {}
    }

    final authUserStr = CacheHelper.getDataString(key: 'CACHED_AUTH_USER');
    if (authUserStr != null && authUserStr.isNotEmpty) {
      try {
        final Map<String, dynamic> authJson = jsonDecode(authUserStr);
        final userData = authJson['data']?['user'] ?? authJson['user'] ?? authJson;
        return ProfileModel.fromJson({'user': userData});
      } catch (_) {}
    }

    return _buildDefaultProfile();
  }

  @override
  Future<void> cacheProfile(ProfileModel profileToCache) async {
    await CacheHelper.saveData(
      key: cachedProfileKey,
      value: jsonEncode(profileToCache.toJson()),
    );
  }

  @override
  Future<bool> updateProfileLocal({
    required String name,
    required String phone,
  }) async {
    return true;
  }

  @override
  Future<bool> signOutLocal() async {
    await CacheHelper.removeData(key: cachedProfileKey);
    await CacheHelper.removeData(key: 'CACHED_AUTH_TOKEN');
    await CacheHelper.removeData(key: 'CACHED_AUTH_USER');
    await CacheHelper.removeData(key: 'token');
    return true;
  }

  ProfileModel _buildDefaultProfile() {
    return const ProfileModel(
      user: UserProfileModel(
        id: '#AL-98421',
        name: 'Aura Client',
        tier: 'Tier 01',
        tierTitle: 'VIP Luminary',
        patronSince: 'Oct 2026',
        avatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
        targetTier: 'TIER 02 SOVEREIGN',
        progress: 0.78,
        spentAmount: '\$12,450 spent',
        remainingToPrivilege: '\$2,550 to Sovereign Privileges',
        deliveredCount: '14',
        curationsCount: '28',
        vaultCredit: '\$450',
      ),
      liaison: ConciergeLiaisonModel(
        name: 'Marcus Vance',
        role: 'Dedicated White-Glove Stylist & Courier',
        dispatchStatus: 'Priority Dispatch',
      ),
    );
  }
}
