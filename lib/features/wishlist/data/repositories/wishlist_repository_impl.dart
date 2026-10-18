import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/wishlist/data/datasources/wishlist_local_data_source.dart';
import 'package:aura/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  const WishlistRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final WishlistRemoteDataSource remoteDataSource;
  final WishlistLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, WishlistEntity>> getWishlist() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWishlist = await remoteDataSource.getWishlist();
        await localDataSource.cacheWishlist(remoteWishlist);
        return Right(remoteWishlist);
      } catch (e) {
        try {
          final localWishlist = await localDataSource.getLastWishlist();
          return Right(localWishlist);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localWishlist = await localDataSource.getLastWishlist();
        return Right(localWishlist);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromWishlist({
    required String productId,
  }) async {
    try {
      final isRemoved =
          await localDataSource.removeFromWishlistLocal(productId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.removeFromWishlist(productId: productId);
      }
      return Right(isRemoved);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> moveAllToBag() async {
    try {
      final isMoved = await localDataSource.moveAllToBagLocal();
      if (await networkInfo.isConnected) {
        await remoteDataSource.moveAllToBag();
      }
      return Right(isMoved);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
