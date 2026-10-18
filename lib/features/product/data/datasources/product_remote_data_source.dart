import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/product/data/models/product_details_model.dart';
import 'package:aura/features/product/data/models/sub_models/product_review_model.dart';

abstract class ProductRemoteDataSource {
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
