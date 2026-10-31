import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/network/connection/network_info.dart';
import 'package:aura/features/category/data/datasources/category_local_data_source.dart';
import 'package:aura/features/category/data/datasources/category_remote_data_source.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        if (remoteCategories.isNotEmpty) {
          await localDataSource.cacheCategories(remoteCategories);
        }
        return Right(remoteCategories);
      } on ServerException catch (e) {
        try {
          final cached = await localDataSource.getCachedCategories();
          return Right(cached);
        } catch (_) {
          return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
        }
      } catch (_) {
        try {
          final cached = await localDataSource.getCachedCategories();
          return Right(cached);
        } catch (_) {
          return const Left(ServerFailure(errMessage: 'An unexpected error occurred while fetching categories'));
        }
      }
    } else {
      try {
        final cached = await localDataSource.getCachedCategories();
        return Right(cached);
      } catch (_) {
        return const Left(NetworkFailure(errMessage: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getCategoryDetails(id);
        await localDataSource.cacheCategoryDetails(remoteCategory);
        return Right(remoteCategory);
      } catch (_) {
        try {
          final cached = await localDataSource.getCachedCategoryDetails(id);
          if (cached != null) return Right(cached);
        } catch (_) {}
        return const Left(ServerFailure(errMessage: 'An unexpected error occurred while fetching category details'));
      }
    } else {
      try {
        final cached = await localDataSource.getCachedCategoryDetails(id);
        if (cached != null) return Right(cached);
        return const Left(CacheFailure(errMessage: 'Category not found in offline cache'));
      } catch (_) {
        return const Left(NetworkFailure(errMessage: 'No internet connection'));
      }
    }
  }
}
