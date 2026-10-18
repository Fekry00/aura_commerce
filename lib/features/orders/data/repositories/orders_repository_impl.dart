import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:aura/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/entities/sub_entities/order_tracking_entity.dart';
import 'package:aura/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  const OrdersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final OrdersRemoteDataSource remoteDataSource;
  final OrdersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetails({String? orderId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOrder =
            await remoteDataSource.getOrderDetails(orderId: orderId);
        await localDataSource.cacheOrder(remoteOrder);
        return Right(remoteOrder);
      } catch (e) {
        try {
          final localOrder =
              await localDataSource.getLastOrderDetails(orderId: orderId);
          return Right(localOrder);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localOrder =
            await localDataSource.getLastOrderDetails(orderId: orderId);
        return Right(localOrder);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, OrderTrackingEntity>> getOrderTracking({
    String? orderId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTracking =
            await remoteDataSource.getOrderTracking(orderId: orderId);
        return Right(remoteTracking);
      } catch (e) {
        try {
          final localTracking =
              await localDataSource.getLastOrderTracking(orderId: orderId);
          return Right(localTracking);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.toString()));
        }
      }
    } else {
      try {
        final localTracking =
            await localDataSource.getLastOrderTracking(orderId: orderId);
        return Right(localTracking);
      } catch (e) {
        return Left(
          CacheFailure(errMessage: 'No internet connection: ${e.toString()}'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, bool>> downloadInvoice({required String orderId}) async {
    try {
      if (await networkInfo.isConnected) {
        final isDownloaded =
            await remoteDataSource.downloadInvoice(orderId: orderId);
        return Right(isDownloaded);
      }
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
