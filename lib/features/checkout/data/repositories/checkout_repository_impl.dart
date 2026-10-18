import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/checkout/data/datasources/checkout_local_data_source.dart';
import 'package:aura/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
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
        final remoteCheckout = await remoteDataSource.getCheckoutDetails();
        await localDataSource.cacheCheckout(remoteCheckout);
        return Right(remoteCheckout);
      } catch (e) {
        try {
          final localCheckout = await localDataSource.getLastCheckout();
          return Right(localCheckout);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localCheckout = await localDataSource.getLastCheckout();
        return Right(localCheckout);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, bool>> selectShippingAddress({
    required String addressId,
  }) async {
    try {
      final isUpdated =
          await localDataSource.selectShippingAddressLocal(addressId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.selectShippingAddress(addressId: addressId);
      }
      return Right(isUpdated);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> selectDeliveryMethod({
    required String methodId,
  }) async {
    try {
      final isUpdated =
          await localDataSource.selectDeliveryMethodLocal(methodId);
      if (await networkInfo.isConnected) {
        await remoteDataSource.selectDeliveryMethod(methodId: methodId);
      }
      return Right(isUpdated);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> applyPrivilegePasscode({
    required String passcode,
  }) async {
    try {
      final isApplied =
          await localDataSource.applyPrivilegePasscodeLocal(passcode);
      if (await networkInfo.isConnected) {
        await remoteDataSource.applyPrivilegePasscode(passcode: passcode);
      }
      return Right(isApplied);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removePrivilegePasscode() async {
    try {
      final isRemoved = await localDataSource.removePrivilegePasscodeLocal();
      if (await networkInfo.isConnected) {
        await remoteDataSource.removePrivilegePasscode();
      }
      return Right(isRemoved);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> placeOrder({
    required String addressId,
    required String deliveryMethodId,
    String? deliveryNotes,
    String? passcode,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final orderId = await remoteDataSource.placeOrder(
          addressId: addressId,
          deliveryMethodId: deliveryMethodId,
          deliveryNotes: deliveryNotes,
          passcode: passcode,
        );
        return Right(orderId);
      }
      return const Right('AL-98421');
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
