import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/product/data/models/product_details_model.dart';
import 'package:aura/features/product/data/models/product_list_model.dart';
import 'package:aura/features/product/data/models/sub_models/product_review_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductListModel> getProducts({
    String? search,
    int? categoryId,
    String? filterBy,
    bool? inStock,
    num? minPrice,
    num? maxPrice,
    String? sortBy,
    int? page,
    int? perPage,
  });

  Future<ProductDetailsModel> getProductDetails({required String productId});

  Future<List<ProductReviewModel>> getProductReviews({
    required String productId,
  });

  Future<bool> toggleFavorite({required String productId});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<ProductListModel> getProducts({
    String? search,
    int? categoryId,
    String? filterBy,
    bool? inStock,
    num? minPrice,
    num? maxPrice,
    String? sortBy,
    int? page,
    int? perPage,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (search != null && search.isNotEmpty) queryParameters['search'] = search;
    if (categoryId != null) queryParameters['category_id'] = categoryId;
    if (filterBy != null && filterBy.isNotEmpty) {
      queryParameters['filter_by'] = filterBy;
    }
    if (inStock != null) queryParameters['in_stock'] = inStock;
    if (minPrice != null) queryParameters['min_price'] = minPrice;
    if (maxPrice != null) queryParameters['max_price'] = maxPrice;
    if (sortBy != null && sortBy.isNotEmpty) {
      queryParameters['sort_by'] = sortBy;
    }
    if (page != null) queryParameters['page'] = page;
    if (perPage != null) queryParameters['per_page'] = perPage;

    final response = await apiConsumer.get(
      EndPoint.products,
      queryParameters: queryParameters,
    );
    return ProductListModel.fromJson(response);
  }

  @override
  Future<ProductDetailsModel> getProductDetails({
    required String productId,
  }) async {
    final response = await apiConsumer.get('${EndPoint.products}/$productId');
    return ProductDetailsModel.fromJson(response);
  }

  @override
  Future<List<ProductReviewModel>> getProductReviews({
    required String productId,
  }) async {
    final response = await apiConsumer.get(
      '${EndPoint.products}/$productId/reviews',
    );
    return (response['reviews'] as List<dynamic>? ?? [])
        .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> toggleFavorite({required String productId}) async {
    final response = await apiConsumer.post('${EndPoint.favorites}/$productId');
    return response['success'] ?? true;
  }
}
