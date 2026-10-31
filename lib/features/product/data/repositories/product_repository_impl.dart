import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/product/data/datasources/product_local_data_source.dart';
import 'package:aura/features/product/data/datasources/product_remote_data_source.dart';
import 'package:aura/features/product/data/models/product_list_model.dart';
import 'package:aura/features/product/domain/entities/product_details_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
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
  }) async {
    try {
      final remoteList = await remoteDataSource.getProducts(
        search: search,
        categoryId: categoryId,
        filterBy: filterBy,
        inStock: inStock,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
        page: page,
        perPage: perPage,
      );
      if (remoteList.items.isNotEmpty) {
        await localDataSource.cacheProductList(
          remoteList,
          categoryId: categoryId,
        );
      }
      return Right(remoteList);
    } catch (e) {
      try {
        final cachedList = await localDataSource.getLastProductList(
          categoryId: categoryId,
        );
        if (cachedList.items.isNotEmpty) {
          return Right(cachedList);
        }
      } catch (_) {}
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails({
    required String productId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDetails = await remoteDataSource.getProductDetails(
          productId: productId,
        );
        List<ProductReviewEntity> reviews = remoteDetails.reviews;
        if (reviews.isEmpty) {
          try {
            final fetchedReviews = await remoteDataSource.getProductReviews(
              productId: productId,
            );
            if (fetchedReviews.isNotEmpty) {
              reviews = fetchedReviews;
            }
          } catch (_) {}
        }
        final combinedDetails = ProductDetailsEntity(
          product: remoteDetails.product,
          reviews: reviews,
        );
        await localDataSource.cacheProductDetails(productId, remoteDetails);
        return Right(combinedDetails);
      } catch (e) {
        try {
          final localDetails = await localDataSource.getLastProductDetails(
            productId,
          );
          return Right(localDetails);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localDetails = await localDataSource.getLastProductDetails(
          productId,
        );
        return Right(localDetails);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductReviewEntity>>> getProductReviews({
    required String productId,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final reviews = await remoteDataSource.getProductReviews(
          productId: productId,
        );
        return Right(reviews);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductReviewEntity>> submitProductReview({
    required String productId,
    required double rating,
    required String comment,
  }) async {
    try {
      final review = await remoteDataSource.submitProductReview(
        productId: productId,
        rating: rating,
        comment: comment,
      );
      return Right(review);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite({
    required String productId,
  }) async {
    try {
      final isFavorite = await localDataSource.toggleFavoriteLocal(productId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.toggleFavorite(
          productId: productId,
          isCurrentlyFavorite: !isFavorite,
        );
      }
      return Right(isFavorite);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
