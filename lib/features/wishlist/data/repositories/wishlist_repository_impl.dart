import 'package:aura/core/errors/exceptions.dart';
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
      } on ServerException catch (e) {
        try {
          final localWishlist = await localDataSource.getLastWishlist();
          return Right(localWishlist);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
        }
      } catch (_) {
        try {
          final localWishlist = await localDataSource.getLastWishlist();
          return Right(localWishlist);
        } catch (_) {
          return const Left(ServerFailure(errMessage: 'An unexpected error occurred while fetching wishlist'));
        }
      }
    } else {
      try {
        final localWishlist = await localDataSource.getLastWishlist();
        return Right(localWishlist);
      } catch (_) {
        return const Left(NetworkFailure(errMessage: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> addToWishlist({
    required int productId,
  }) async {
    try {
      final isAdded = await localDataSource.addToWishlistLocal(productId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.addToWishlist(productId: productId);
      }
      return Right(isAdded);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (_) {
      return const Left(ServerFailure(errMessage: 'Failed to add item to wishlist'));
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
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (_) {
      return const Left(ServerFailure(errMessage: 'Failed to remove item from wishlist'));
    }
  }

  @override
  Future<Either<Failure, bool>> moveAllToBag() async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.moveAllToBag();
      }
      final isMoved = await localDataSource.moveAllToBagLocal();
      return Right(isMoved);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (_) {
      return const Left(ServerFailure(errMessage: 'Failed to move items to bag'));
    }
  }
}
