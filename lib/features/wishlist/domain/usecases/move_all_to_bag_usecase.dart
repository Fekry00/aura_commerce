import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class MoveAllToBagUseCase {
  const MoveAllToBagUseCase(this.repository);

  final WishlistRepository repository;

  Future<Either<Failure, bool>> call() {
    return repository.moveAllToBag();
  }
}
