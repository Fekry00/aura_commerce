import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';


class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase(this.repository);

  final HomeRepository repository;

  Future<Either<Failure, bool>> call({required String productId}) {
    return repository.toggleFavoriteProduct(productId: productId);
  }
}