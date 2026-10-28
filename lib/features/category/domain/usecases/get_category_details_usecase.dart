import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/usecase/usecase.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoryDetailsUseCase implements UseCase<CategoryEntity, int> {
  const GetCategoryDetailsUseCase(this.repository);

  final CategoryRepository repository;

  @override
  Future<Either<Failure, CategoryEntity>> call(int id) {
    return repository.getCategoryDetails(id);
  }
}
