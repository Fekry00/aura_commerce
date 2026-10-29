import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/checkout/data/datasources/checkout_local_data_source.dart';
import 'package:aura/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final CheckoutRemoteDataSource remoteDataSource;
  final CheckoutLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, CheckoutEntity>> getCheckoutDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getCheckoutDetails();
        return Right(remote);
      } on ServerException catch (e) {
        try {
          final local = await localDataSource.getLastCheckout();
          return Right(local);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
        }
      } catch (_) {
        try {
          final local = await localDataSource.getLastCheckout();
          return Right(local);
        } catch (_) {
          return const Left(ServerFailure(errMessage: 'An unexpected error occurred while fetching checkout'));
        }
      }
    } else {
      try {
        final local = await localDataSource.getLastCheckout();
        return Right(local);
      } catch (_) {
        return const Left(NetworkFailure(errMessage: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> selectShippingAddress({
    required String addressId,
  }) async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> selectDeliveryMethod({
    required String methodId,
  }) async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> applyPrivilegePasscode({
    required String passcode,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(errMessage: 'No internet connection'));
    }
    try {
      final res =
          await remoteDataSource.applyPrivilegePasscode(passcode: passcode);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (_) {
      return const Left(ServerFailure(errMessage: 'Failed to apply privilege passcode'));
    }
  }

  @override
  Future<Either<Failure, bool>> removePrivilegePasscode() async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, OrderEntity>> placeOrder({
    required String shippingAddress,
    required String phone,
    String paymentMethod = 'cod',
    String? notes,
    List<Map<String, dynamic>>? items,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(errMessage: 'No internet connection'));
    }
    try {
      final order = await remoteDataSource.placeOrder(
        shippingAddress: shippingAddress,
        phone: phone,
        paymentMethod: paymentMethod,
        notes: notes,
        items: items,
      );
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (_) {
      return const Left(ServerFailure(errMessage: 'Failed to place order'));
    }
  }
}
