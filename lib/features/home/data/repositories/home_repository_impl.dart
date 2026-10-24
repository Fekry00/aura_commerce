import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/home/data/datasources/home_local_data_source.dart';
import 'package:aura/features/home/data/datasources/home_remote_data_source.dart';
import 'package:aura/features/home/domain/entities/home_feed_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:aura/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, HomeFeedEntity>> getHomeFeed() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteFeed = await remoteDataSource.getHomeFeed();
        final localFeed = await localDataSource.getLastHomeFeed();
        final combinedFeed = HomeFeedEntity(
          deliveryLocation: remoteFeed.deliveryLocation,
          banners: remoteFeed.banners,
          categories: remoteFeed.categories,
          highlights: remoteFeed.highlights.isNotEmpty
              ? remoteFeed.highlights
              : localFeed.highlights,
          curatedDrop: remoteFeed.curatedDrop ?? localFeed.curatedDrop,
          archiveStory: remoteFeed.archiveStory ?? localFeed.archiveStory,
        );
        return Right(combinedFeed);
      } catch (e) {
        try {
          final localFeed = await localDataSource.getLastHomeFeed();
          return Right(localFeed);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localFeed = await localDataSource.getLastHomeFeed();
        return Right(localFeed);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductHighlightEntity>>> getHighlights({
    bool onlyPopular = false,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final highlights = await remoteDataSource.getHighlights(
          onlyPopular: onlyPopular,
        );
        return Right(highlights);
      } else {
        final feed = await localDataSource.getLastHomeFeed();
        final highlights = feed.highlights.cast<ProductHighlightEntity>();
        if (!onlyPopular) return Right(highlights);
        return Right(highlights.where((item) => item.isPopular).toList());
      }
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavoriteProduct({
    required String productId,
    bool isCurrentlyFavorite = false,
  }) async {
    try {
      final isFavorite = await localDataSource.toggleFavoriteLocal(productId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.toggleFavoriteProduct(
          productId: productId,
          isCurrentlyFavorite: isCurrentlyFavorite,
        );
      }
      return Right(isFavorite);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
