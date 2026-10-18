import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/domain/entities/product_details_entity.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductDetailsUseCase {
  const GetProductDetailsUseCase(this.repository);

  final ProductRepository repository;

  Future<Either<Failure, ProductDetailsEntity>> call({
    required String productId,
  }) {
    return repository.getProductDetails(productId: productId);
  }
}
