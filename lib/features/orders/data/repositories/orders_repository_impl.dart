import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/orders/data/datasources/orders_local_data_source.dart';
import 'package:aura/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
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
  Future<Either<Failure, List<OrderEntity>>> getMyOrders({
    String? status,
    int? perPage,
    int? page,
  }) async {
    try {
      final remoteList = await remoteDataSource.getMyOrders(
        status: status,
        perPage: perPage,
        page: page,
      );
      return Right(remoteList.items);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetails(int orderId) async {
    try {
      final order = await remoteDataSource.getOrderDetails(orderId);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> cancelOrder(int orderId) async {
    try {
      final cancelled = await remoteDataSource.cancelOrder(orderId);
      return Right(cancelled);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> downloadInvoice({required String orderId}) async {
    try {
      final success = await remoteDataSource.downloadInvoice(orderId: orderId);
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
