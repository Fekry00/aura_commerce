import 'package:aura/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

export 'package:aura/core/utils/params.dart';

/// Base contract for UseCases requiring parameters.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Base contract for UseCases requiring no parameters.
abstract class UseCaseNoParams<T> {
  Future<Either<Failure, T>> call();
}
