import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();

  Future<Either<Failure, bool>> addToCart({
    required int productId,
    int quantity = 1,
  });

  Future<Either<Failure, bool>> updateCartItemQuantity({
    required String itemId,
    required int quantity,
  });

  Future<Either<Failure, bool>> removeCartItem({
    required String itemId,
  });

  Future<Either<Failure, bool>> clearCart();

  Future<Either<Failure, bool>> applyVoucher({
    required String promoCode,
  });

  Future<Either<Failure, bool>> removeVoucher();
}
