import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, CheckoutEntity>> getCheckoutDetails();

  Future<Either<Failure, bool>> selectShippingAddress({
    required String addressId,
  });

  Future<Either<Failure, bool>> selectDeliveryMethod({
    required String methodId,
  });

  Future<Either<Failure, bool>> applyPrivilegePasscode({
    required String passcode,
  });

  Future<Either<Failure, bool>> removePrivilegePasscode();

  Future<Either<Failure, OrderEntity>> placeOrder({
    required String shippingAddress,
    required String phone,
    String paymentMethod = 'cod',
    String? notes,
    List<Map<String, dynamic>>? items,
  });
}
