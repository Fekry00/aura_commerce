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
    try {
      final remote = await remoteDataSource.getCheckoutDetails();
      return Right(remote);
    } catch (e) {
      final local = await localDataSource.getLastCheckout();
      return Right(local);
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
    try {
      final res = await remoteDataSource.applyPrivilegePasscode(passcode: passcode);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
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
    try {
      final order = await remoteDataSource.placeOrder(
        shippingAddress: shippingAddress,
        phone: phone,
        paymentMethod: paymentMethod,
        notes: notes,
        items: items,
      );
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
