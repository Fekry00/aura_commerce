import 'dart:convert';

import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/wishlist/data/models/sub_models/sanctuary_summary_model.dart';
import 'package:aura/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistLocalDataSource {
  Future<WishlistModel> getLastWishlist();

  Future<void> cacheWishlist(WishlistModel wishlistToCache);

  Future<bool> addToWishlistLocal(int productId);

  Future<bool> removeFromWishlistLocal(String productId);

  Future<bool> moveAllToBagLocal();
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  const WishlistLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedWishlistKey = 'CACHED_WISHLIST';

  @override
  Future<WishlistModel> getLastWishlist() async {
    final cachedData = CacheHelper.getDataString(key: cachedWishlistKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        return WishlistModel.fromJson(decoded);
      } catch (_) {}
    }
    return _emptyWishlist();
  }

  @override
  Future<void> cacheWishlist(WishlistModel wishlistToCache) async {
    await CacheHelper.saveData(
      key: cachedWishlistKey,
      value: jsonEncode(wishlistToCache.toJson()),
    );
  }

  @override
  Future<bool> addToWishlistLocal(int productId) async {
    return true;
  }

  @override
  Future<bool> removeFromWishlistLocal(String productId) async {
    return true;
  }

  @override
  Future<bool> moveAllToBagLocal() async {
    return true;
  }

  WishlistModel _emptyWishlist() {
    return const WishlistModel(
      sanctuarySummary: SanctuarySummaryModel(
        totalAmount: 0.0,
        itemCount: 0,
        description: '',
      ),
      items: [],
    );
  }
}

