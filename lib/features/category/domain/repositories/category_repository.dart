import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, CategoryEntity>> getCategoryDetails(int id);
}
