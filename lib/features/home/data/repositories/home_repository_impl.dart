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
    try {
      final remoteFeed = await remoteDataSource.getHomeFeed();
      // Cache the fresh remote feed for offline availability
      await localDataSource.cacheHomeFeed(remoteFeed);

      final localFeed = await localDataSource.getLastHomeFeed();
      final combinedFeed = HomeFeedEntity(
        deliveryLocation: remoteFeed.deliveryLocation,
        banners: remoteFeed.banners,
        categories: remoteFeed.categories,
        highlights: remoteFeed.highlights,
        curatedDrop: remoteFeed.curatedDrop ?? localFeed.curatedDrop,
        archiveStory: remoteFeed.archiveStory ?? localFeed.archiveStory,
      );
      return Right(combinedFeed);
    } catch (e) {
      // Remote call failed (e.g., adb reverse dropped or server temporarily unreachable)
      // Fallback gracefully to cached feed so app never opens blank
      try {
        final cachedFeed = await localDataSource.getLastHomeFeed();
        if (cachedFeed.highlights.isNotEmpty || cachedFeed.categories.isNotEmpty) {
          return Right(cachedFeed);
        }
      } catch (_) {}

      return Left(ServerFailure(errMessage: 'Connection failed: ${e.toString()}'));
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
      }
    } catch (_) {}

    try {
      final cachedFeed = await localDataSource.getLastHomeFeed();
      if (cachedFeed.highlights.isNotEmpty) {
        return Right(cachedFeed.highlights);
      }
    } catch (_) {}

    return const Left(NetworkFailure(errMessage: 'No internet connection'));
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
