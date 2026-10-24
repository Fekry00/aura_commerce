import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/data/models/product_list_model.dart';
import 'package:aura/features/product/domain/entities/product_details_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductListModel>> getProducts({
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

  Future<Either<Failure, ProductDetailsEntity>> getProductDetails({
    required String productId,
  });

  Future<Either<Failure, List<ProductReviewEntity>>> getProductReviews({
    required String productId,
  });

  Future<Either<Failure, bool>> toggleFavorite({
    required String productId,
  });
}
