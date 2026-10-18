import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/home/data/models/home_feed_model.dart';
import 'package:aura/features/home/data/models/sub_models/product_highlight_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeFeedModel> getHomeFeed();

  Future<List<ProductHighlightModel>> getHighlights({bool onlyPopular = false});

  Future<bool> toggleFavoriteProduct({required String productId});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<HomeFeedModel> getHomeFeed() async {
    final response = await apiConsumer.get(EndPoint.home);
    return HomeFeedModel.fromJson(response);
  }

  @override
  Future<List<ProductHighlightModel>> getHighlights({
    bool onlyPopular = false,
  }) async {
    final feed = await getHomeFeed();
    final models = feed.highlights.cast<ProductHighlightModel>();
    if (!onlyPopular) return models;
    return models.where((item) => item.isPopular).toList();
  }

  @override
  Future<bool> toggleFavoriteProduct({required String productId}) async {
    final response = await apiConsumer.post('${EndPoint.favorites}/$productId');
    return response['success'] ?? true;
  }
}
