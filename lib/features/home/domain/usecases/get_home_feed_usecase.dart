import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/home/domain/entities/home_feed_entity.dart';
import 'package:aura/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetHomeFeedUseCase {
  const GetHomeFeedUseCase(this.repository);

  final HomeRepository repository;

  Future<Either<Failure, HomeFeedEntity>> call() {
    return repository.getHomeFeed();
  }
}
