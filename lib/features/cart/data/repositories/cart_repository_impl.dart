import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:aura/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCart = await remoteDataSource.getCart();
        await localDataSource.cacheCart(remoteCart);
        return Right(remoteCart);
      } catch (e) {
        try {
          final localCart = await localDataSource.getLastCart();
          return Right(localCart);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localCart = await localDataSource.getLastCart();
        return Right(localCart);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, bool>> updateCartItemQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final isUpdated = await localDataSource.updateCartItemQuantityLocal(
        itemId: itemId,
        quantity: quantity,
      );
      if (await networkInfo.isConnected) {
        await remoteDataSource.updateCartItemQuantity(
          itemId: itemId,
          quantity: quantity,
        );
      }
      return Right(isUpdated);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeCartItem({
    required String itemId,
  }) async {
    try {
      final isRemoved = await localDataSource.removeCartItemLocal(
        itemId: itemId,
      );
      if (await networkInfo.isConnected) {
        await remoteDataSource.removeCartItem(itemId: itemId);
      }
      return Right(isRemoved);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> applyVoucher({
    required String promoCode,
  }) async {
    try {
      final isApplied = await localDataSource.applyVoucherLocal(
        promoCode: promoCode,
      );
      if (await networkInfo.isConnected) {
        await remoteDataSource.applyVoucher(promoCode: promoCode);
      }
      return Right(isApplied);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeVoucher() async {
    try {
      final isRemoved = await localDataSource.removeVoucherLocal();
      if (await networkInfo.isConnected) {
        await remoteDataSource.removeVoucher();
      }
      return Right(isRemoved);
    } catch (e) {
      return Left(CacheFailure(errMessage: e.toString()));
    }
  }
}
