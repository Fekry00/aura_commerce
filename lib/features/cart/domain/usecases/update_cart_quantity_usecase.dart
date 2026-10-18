import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCartQuantityUseCase {
  const UpdateCartQuantityUseCase(this.repository);

  final CartRepository repository;

  Future<Either<Failure, bool>> call({
    required String itemId,
    required int quantity,
  }) {
    return repository.updateCartItemQuantity(
      itemId: itemId,
      quantity: quantity,
    );
  }
}
