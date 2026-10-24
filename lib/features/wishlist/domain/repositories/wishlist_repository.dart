import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<Failure, WishlistEntity>> getWishlist();

  Future<Either<Failure, bool>> addToWishlist({
    required int productId,
  });

  Future<Either<Failure, bool>> removeFromWishlist({
    required String productId,
  });

  Future<Either<Failure, bool>> moveAllToBag();
}
