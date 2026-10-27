import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/product/data/models/product_details_model.dart';
import 'package:aura/features/product/data/models/sub_models/product_item_model.dart';

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
    final idInt = int.tryParse(productId) ?? 1;
    return ProductDetailsModel(
      product: ProductItemModel(
        id: idInt,
        name: 'iPhone 15 Pro',
        slug: 'iphone-15-pro',
        description: 'Latest iPhone 15 Pro with 256GB storage.',
        thumbnailUrl: '${EndPoint.serverUrl}/storage/products/iphone.jpg',
        minPrice: 45000,
        compareAtPrice: 50000,
        discountPercent: 10,
        stock: 98,
        inStock: true,
        categoryName: 'Electronics',
        categoryId: 1,
        isFavorite: true,
      ),
      reviews: const [],
    );
  }
}
