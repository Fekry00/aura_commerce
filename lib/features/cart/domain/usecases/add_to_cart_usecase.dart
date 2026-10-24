import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class AddToCartUseCase {
  const AddToCartUseCase(this.repository);

  final CartRepository repository;

  Future<Either<Failure, bool>> call({
    required int productId,
    int quantity = 1,
  }) {
    return repository.addToCart(
      productId: productId,
      quantity: quantity,
    );
  }
}
