import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/usecase/usecase.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUseCase implements UseCaseNoParams<List<CategoryEntity>> {
  const GetCategoriesUseCase(this.repository);

  final CategoryRepository repository;

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}
