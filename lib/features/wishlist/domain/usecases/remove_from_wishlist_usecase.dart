import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveFromWishlistUseCase {
  const RemoveFromWishlistUseCase(this.repository);

  final WishlistRepository repository;

  Future<Either<Failure, bool>> call({required String productId}) {
    return repository.removeFromWishlist(productId: productId);
  }
}
