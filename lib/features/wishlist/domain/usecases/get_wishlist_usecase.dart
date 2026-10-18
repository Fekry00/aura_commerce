import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWishlistUseCase {
  const GetWishlistUseCase(this.repository);

  final WishlistRepository repository;

  Future<Either<Failure, WishlistEntity>> call() {
    return repository.getWishlist();
  }
}
