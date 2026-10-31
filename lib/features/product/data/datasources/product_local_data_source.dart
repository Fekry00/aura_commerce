import 'dart:convert';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/product/data/models/product_details_model.dart';
import 'package:aura/features/product/data/models/product_list_model.dart';
import 'package:aura/features/product/data/models/sub_models/product_item_model.dart';

abstract class ProductLocalDataSource {
  Future<ProductDetailsModel> getLastProductDetails(String productId);

  Future<void> cacheProductDetails(
    String productId,
    ProductDetailsModel detailsToCache,
  );

  Future<ProductListModel> getLastProductList({int? categoryId});

  Future<void> cacheProductList(
    ProductListModel listToCache, {
    int? categoryId,
  });

  Future<bool> toggleFavoriteLocal(String productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  const ProductLocalDataSourceImpl();

  static const String cachedProductPrefix = 'CACHED_PRODUCT_';
  static const String cachedProductListPrefix = 'CACHED_PRODUCT_LIST_';

  @override
  Future<ProductDetailsModel> getLastProductDetails(String productId) async {
    final cachedData = CacheHelper.getDataString(key: '$cachedProductPrefix$productId');
    if (cachedData != null && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        return ProductDetailsModel.fromJson(decoded);
      } catch (_) {}
    }
    return _buildDefaultProductDetails(productId);
  }

  @override
  Future<void> cacheProductDetails(
    String productId,
    ProductDetailsModel detailsToCache,
  ) async {
    try {
      await CacheHelper.saveData(
        key: '$cachedProductPrefix$productId',
        value: jsonEncode(detailsToCache.toJson()),
      );
    } catch (_) {}
  }

  @override
  Future<ProductListModel> getLastProductList({int? categoryId}) async {
    final key = '$cachedProductListPrefix${categoryId ?? 'ALL'}';
    final cachedData = CacheHelper.getDataString(key: key);
    if (cachedData != null && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        return ProductListModel.fromJson(decoded);
      } catch (_) {}
    }
    return const ProductListModel(
      items: [],
      pagination: ProductPaginationModel(
        currentPage: 1,
        pageSize: 20,
        totalItems: 0,
        totalPages: 1,
      ),
    );
  }

  @override
  Future<void> cacheProductList(
    ProductListModel listToCache, {
    int? categoryId,
  }) async {
    try {
      final key = '$cachedProductListPrefix${categoryId ?? 'ALL'}';
      await CacheHelper.saveData(
        key: key,
        value: jsonEncode(listToCache.toJson()),
      );
    } catch (_) {}
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
