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

  Future<ProductReviewModel> submitProductReview({
    required String productId,
    required double rating,
    required String comment,
  });

  Future<bool> toggleFavorite({
    required String productId,
    bool isCurrentlyFavorite = false,
  });
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
    final data = response['data'];
    List<dynamic> items = [];
    if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else if (data is List) {
      items = data;
    } else if (response['reviews'] is List) {
      items = response['reviews'] as List<dynamic>;
    }
    return items
        .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductReviewModel> submitProductReview({
    required String productId,
    required double rating,
    required String comment,
  }) async {
    final response = await apiConsumer.post(
      '${EndPoint.products}/$productId/reviews',
      data: {
        'rating': rating.toInt(),
        'comment': comment,
      },
    );
    final data = response['data'] is Map<String, dynamic>
        ? response['data'] as Map<String, dynamic>
        : response;
    return ProductReviewModel.fromJson(data);
  }

  @override
  Future<bool> toggleFavorite({
    required String productId,
    bool isCurrentlyFavorite = false,
  }) async {
    final intId = int.tryParse(productId) ?? 1;
    if (isCurrentlyFavorite) {
      final response =
          await apiConsumer.delete('${EndPoint.favorites}/$productId');
      return response['success'] ?? true;
    } else {
      final response = await apiConsumer.post(
        EndPoint.favorites,
        data: {'productId': intId},
      );
      return response['success'] ?? true;
    }
  }
}
