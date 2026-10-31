import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/cart/domain/entities/sub_entities/store_settings_entity.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoreSettingsUseCase {
  const GetStoreSettingsUseCase(this.repository);

  final CartRepository repository;

  Future<Either<Failure, StoreSettingsEntity>> call() {
    return repository.getStoreSettings();
  }
}
