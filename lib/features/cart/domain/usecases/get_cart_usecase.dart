import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetCartUseCase {
  const GetCartUseCase(this.repository);

  final CartRepository repository;

  Future<Either<Failure, CartEntity>> call() {
    return repository.getCart();
  }
}
