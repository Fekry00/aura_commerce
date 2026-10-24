import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/home/domain/entities/home_feed_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeFeedEntity>> getHomeFeed();

  Future<Either<Failure, List<ProductHighlightEntity>>> getHighlights({
    bool onlyPopular = false,
  });

  Future<Either<Failure, bool>> toggleFavoriteProduct({
    required String productId,
    bool isCurrentlyFavorite = false,
  });
}
