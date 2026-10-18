import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/product/data/models/product_details_model.dart';
import 'package:aura/features/product/data/models/sub_models/product_item_model.dart';
import 'package:aura/features/product/data/models/sub_models/product_review_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductDetailsModel> getLastProductDetails(String productId);

  Future<void> cacheProductDetails(
    String productId,
    ProductDetailsModel detailsToCache,
  );

  Future<bool> toggleFavoriteLocal(String productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  const ProductLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedProductPrefix = 'CACHED_PRODUCT_';

  @override
  Future<ProductDetailsModel> getLastProductDetails(String productId) async {
    return _buildDefaultProductDetails(productId);
  }

  @override
  Future<void> cacheProductDetails(
    String productId,
    ProductDetailsModel detailsToCache,
  ) async {
    // await cacheHelper.saveData(key: '$cachedProductPrefix$productId', value: detailsToCache.toJson());
  }

  @override
  Future<bool> toggleFavoriteLocal(String productId) async {
    return true;
  }

  ProductDetailsModel _buildDefaultProductDetails(String productId) {
    return ProductDetailsModel(
      product: ProductItemModel(
        id: productId.isEmpty ? '1' : productId,
        title: 'Aethel Minimalist Chronograph 40mm',
        price: 1450.00,
        originalPrice: 1650.00,
        rating: 4.9,
        reviewsCount: 128,
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600',
        stockStatus: 'IN STOCK',
        materialSummary:
            'Machined from monolithic 316L cold-forged stainless steel with dual-domed anti-reflective sapphire crystal, engineered to 5 ATM water resistance.',
        calibreDescription:
            'The Aethel Minimalist Chronograph reconciles classic horology with brutalist purity. Featuring custom counterpoised sub-dials and a high-beat automatic movement tuned to +/- 3 seconds daily variance.',
        movement: 'Calibre AT-902 Autowind',
        glass: '9H Sapphire Crystal',
        strapMaterial: 'Full-grain Horween Leather',
        powerReserve: '44-Hour Reserve',
        deliveryDescription:
            'Dispatched via secure armored courier within 24 hours. Transit time 2-3 business days worldwide with door-to-door full valuation insurance.',
        guaranteeDescription:
            'Every AURA timepiece is registered to our global horological registry. Comprehensive servicing, mechanical calibration, and water-resistance seal renewals are guaranteed every 24 months.',
        isFavorite: true,
      ),
      reviews: const [
        ProductReviewModel(
          id: 'rev_1',
          authorName: 'Julian L.',
          authorInitials: 'JL',
          authorStatus: 'Verified Atelier Owner',
          rating: 5.0,
          comment:
              '"The brushed titanium finish absorbs light unlike anything else in my collection. Weighs next to nothing on the wrist, yet feels indestructible. Outstanding design restraint."',
          purchaseInfo: 'Purchased: 40mm / Brushed Titanium • 2 weeks ago',
        ),
      ],
    );
  }
}
