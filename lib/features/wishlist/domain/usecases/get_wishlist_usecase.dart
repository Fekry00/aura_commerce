import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/usecase/usecase.dart';
import 'package:aura/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:aura/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWishlistUseCase implements UseCaseNoParams<WishlistEntity> {
  const GetWishlistUseCase(this.repository);

  final WishlistRepository repository;

  @override
  Future<Either<Failure, WishlistEntity>> call() {
    return repository.getWishlist();
  }
}
