import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/home/data/models/home_feed_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeFeedModel> getLastHomeFeed();

  Future<void> cacheHomeFeed(HomeFeedModel feedToCache);

  Future<bool> toggleFavoriteLocal(String productId);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  static const String cachedHomeFeedKey = 'CACHED_HOME_FEED';

  @override
  Future<HomeFeedModel> getLastHomeFeed() async {
    try {
      final jsonString = CacheHelper.getDataString(key: cachedHomeFeedKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final Map<String, dynamic> map = jsonDecode(jsonString);
        return HomeFeedModel.fromJson(map);
      }
    } catch (_) {}
    return _buildDefaultHomeFeed();
  }

  @override
  Future<void> cacheHomeFeed(HomeFeedModel feedToCache) async {
    try {
      final jsonString = jsonEncode(feedToCache.toJson());
      await CacheHelper.saveData(key: cachedHomeFeedKey, value: jsonString);
    } catch (_) {}
  }

  @override
  Future<bool> toggleFavoriteLocal(String productId) async {
    return true;
  }

  HomeFeedModel _buildDefaultHomeFeed() {
    return const HomeFeedModel(
      deliveryLocation: 'Cairo, EG',
      banners: [],
      curatedDrop: null,
      categories: [],
      highlights: [],
      archiveStory: null,
    );
  }
}

