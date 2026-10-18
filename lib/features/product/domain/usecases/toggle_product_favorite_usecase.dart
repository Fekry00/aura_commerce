import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ToggleProductFavoriteUseCase {
  const ToggleProductFavoriteUseCase(this.repository);

  final ProductRepository repository;

  Future<Either<Failure, bool>> call({required String productId}) {
    return repository.toggleFavorite(productId: productId);
  }
}
