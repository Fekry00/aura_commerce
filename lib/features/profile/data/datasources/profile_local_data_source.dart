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
  const ProfileLocalDataSourceImpl();

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
        id: '',
        name: 'Aura Member',
        tier: 'Member',
        tierTitle: 'Client',
        patronSince: '',
        avatarUrl: '',
        targetTier: '',
        progress: 0.0,
        spentAmount: '0 EGP spent',
        remainingToPrivilege: '',
        deliveredCount: '0',
        curationsCount: '0',
        vaultCredit: '0 EGP',
      ),
      liaison: ConciergeLiaisonModel(
        name: 'Marcus Vance',
        role: 'Dedicated White-Glove Stylist & Courier',
        dispatchStatus: 'Priority Dispatch',
      ),
    );
  }
}
