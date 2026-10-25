import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/data/models/product_list_model.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase {
  const GetProductsUseCase(this.repository);

  final ProductRepository repository;

  Future<Either<Failure, ProductListModel>> call({
    String? search,
    int? categoryId,
    String? filterBy,
    bool? inStock,
    num? minPrice,
    num? maxPrice,
    String? sortBy,
    int? page,
    int? perPage,
  }) {
    return repository.getProducts(
      search: search,
      categoryId: categoryId,
      filterBy: filterBy,
      inStock: inStock,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortBy: sortBy,
      page: page,
      perPage: perPage,
    );
  }
}
