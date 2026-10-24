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
      return Right(remoteList);
    } catch (e) {
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
        await localDataSource.cacheProductDetails(productId, remoteDetails);
        return Right(remoteDetails);
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
        final localDetails = await localDataSource.getLastProductDetails(
          productId,
        );
        return Right(localDetails.reviews);
      }
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
        await remoteDataSource.toggleFavorite(productId: productId);
      }
      return Right(isFavorite);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
