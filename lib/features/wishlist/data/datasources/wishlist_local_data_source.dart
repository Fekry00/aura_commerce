import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/wishlist/data/models/sub_models/sanctuary_summary_model.dart';
import 'package:aura/features/wishlist/data/models/sub_models/wishlist_item_model.dart';
import 'package:aura/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistLocalDataSource {
  Future<WishlistModel> getLastWishlist();

  Future<void> cacheWishlist(WishlistModel wishlistToCache);

  Future<bool> removeFromWishlistLocal(String productId);

  Future<bool> moveAllToBagLocal();
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  const WishlistLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedWishlistKey = 'CACHED_WISHLIST';

  @override
  Future<WishlistModel> getLastWishlist() async {
    return _buildDefaultWishlist();
  }

  @override
  Future<void> cacheWishlist(WishlistModel wishlistToCache) async {
    // await cacheHelper.saveData(key: cachedWishlistKey, value: wishlistToCache.toJson());
  }

  @override
  Future<bool> removeFromWishlistLocal(String productId) async {
    return true;
  }

  @override
  Future<bool> moveAllToBagLocal() async {
    return true;
  }

  WishlistModel _buildDefaultWishlist() {
    return const WishlistModel(
      sanctuarySummary: SanctuarySummaryModel(
        totalAmount: 3659.00,
        itemCount: 4,
        description:
            'Complimentary bespoke packaging, temperature-controlled transit, and signature arrival handling included.',
      ),
      items: [
        WishlistItemModel(
          id: '5',
          title: 'Vitamin C Serum',
          category: 'Skin Care • Atelier Lab',
          price: 999.00,
          originalPrice: 1199.00,
          imageUrl:
              'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=600',
          badge: '-16% Privilege',
          stockStatus: 'In Stock (100 units available)',
        ),
        WishlistItemModel(
          id: '12',
          title: 'Aethel Chronograph 40mm',
          category: 'Haute Horlogerie',
          price: 1450.00,
          imageUrl:
              'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=600',
          stockStatus: 'Low Vault Stock (3 left)',
          isLowStock: true,
        ),
        WishlistItemModel(
          id: '19',
          title: 'Verona Nappa Handbag',
          category: 'Maison Leather • Forest Green',
          price: 890.00,
          originalPrice: 980.00,
          imageUrl:
              'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=600',
          badge: 'Exclusive',
          stockStatus: 'In Stock',
        ),
        WishlistItemModel(
          id: '27',
          title: 'Oud & Bergamot Extrait',
          category: 'Artisan Fragrance • 100ml',
          price: 320.00,
          imageUrl:
              'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?q=80&w=600',
          stockStatus: 'Complimentary Flacon Sample',
          hasComplimentary: true,
        ),
      ],
    );
  }
}
