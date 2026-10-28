import 'package:aura/core/errors/failure.dart';
import 'package:aura/core/usecase/usecase.dart';
import 'package:aura/features/home/domain/entities/home_feed_entity.dart';
import 'package:aura/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetHomeFeedUseCase implements UseCaseNoParams<HomeFeedEntity> {
  const GetHomeFeedUseCase(this.repository);

  final HomeRepository repository;

  @override
  Future<Either<Failure, HomeFeedEntity>> call() {
    return repository.getHomeFeed();
  }
}
