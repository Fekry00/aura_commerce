import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/home/data/models/home_feed_model.dart';
import 'package:aura/features/home/data/models/sub_models/banner_model.dart';
import 'package:aura/features/home/data/models/sub_models/category_model.dart';
import 'package:aura/features/home/data/models/sub_models/product_highlight_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeFeedModel> getHomeFeed();

  Future<List<BannerModel>> getBanners();

  Future<List<CategoryModel>> getCategories();

  Future<List<ProductHighlightModel>> getHighlights({bool onlyPopular = false});

  Future<bool> toggleFavoriteProduct({
    required String productId,
    bool isCurrentlyFavorite = false,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<List<BannerModel>> getBanners() async {
    final response = await apiConsumer.get(EndPoint.banners);
    final list = (response['data'] as List<dynamic>? ?? []);
    return list
        .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiConsumer.get(EndPoint.categories);
    final list = (response['data'] as List<dynamic>? ?? []);
    return list
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<HomeFeedModel> getHomeFeed() async {
    final results = await Future.wait([
      apiConsumer.get(EndPoint.banners),
      apiConsumer.get(EndPoint.categories),
      apiConsumer.get(EndPoint.products),
    ]);

    final bannersData = (results[0]['data'] as List<dynamic>? ?? []);
    final categoriesData = (results[1]['data'] as List<dynamic>? ?? []);
    final productsData = (results[2]['data'] is Map<String, dynamic>
        ? (results[2]['data']['items'] as List<dynamic>? ?? [])
        : (results[2]['data'] as List<dynamic>? ?? []));

    final banners = bannersData
        .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final categories = categoriesData
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final highlights = productsData
        .map((e) => ProductHighlightModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return HomeFeedModel(
      deliveryLocation: 'New York, NY',
      banners: banners,
      categories: categories,
      highlights: highlights,
    );
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
  Future<bool> toggleFavoriteProduct({
    required String productId,
    bool isCurrentlyFavorite = false,
  }) async {
    final intId = int.tryParse(productId) ?? 1;
    if (isCurrentlyFavorite) {
      final response =
          await apiConsumer.delete('${EndPoint.favorites}/$productId');
      return response['success'] ?? true;
    } else {
      final response = await apiConsumer.post(
        EndPoint.favorites,
        data: {'productId': intId},
      );
      return response['success'] ?? true;
    }
  }
}

